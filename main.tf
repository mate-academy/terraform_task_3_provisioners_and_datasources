# Провізіонуємо ІСНУЮЧУ VM через SSH (ключ) + копіюємо index.html і ставимо Nginx
# ПРИМІТКА: на VM має бути дозволений sudo без пароля (NOPASSWD),
# як ти вже робив через az vm run-command.

resource "null_resource" "provision_existing_vm" {
  triggers = {
    vm_id      = data.azurerm_virtual_machine.vm.id
    index_hash = filesha1("index.html")
  }

  connection {
    type        = "ssh"
    host        = data.azurerm_public_ip.pip.ip_address
    user        = var.vm_admin_username
    private_key = file(pathexpand("~/.ssh/id_rsa"))
    agent       = false
    timeout     = "10m"
  }

  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      # дочекатись cloud-init, якщо є
      "if command -v cloud-init >/dev/null 2>&1; then sudo -n cloud-init status --wait || true; fi",

      # інколи apt залочений автооновленнями — чекаємо
      "for i in $(seq 1 30); do sudo -n fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 || sudo -n fuser /var/lib/apt/lists/lock >/dev/null 2>&1 || break; echo 'APT locked, wait...'; sleep 5; done",

      "export DEBIAN_FRONTEND=noninteractive",
      "sudo -n apt-get update -y",
      "sudo -n apt-get install -y nginx",

      "sudo -n mv /tmp/index.html /var/www/html/index.html",
      "sudo -n systemctl enable nginx",
      "sudo -n systemctl restart nginx",

      # швидка валідація
      "curl -sSf http://localhost >/dev/null || (sudo -n journalctl -u nginx --no-pager | tail -n 50 && exit 1)"
    ]
  }
}
