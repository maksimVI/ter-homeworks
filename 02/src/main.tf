resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_name_db
  zone           = var.default_zone_db
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr_db
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform
  zone = var.default_zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vms_metadata.ssh.serial_port_enable
    ssh-keys           = var.vms_metadata.ssh.keys
    # На 6-ом задание больше не используется
    # ssh-keys           = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

}

data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_db_image
}
resource "yandex_compute_instance" "platform_db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform
  zone = var.default_zone_db
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vms_metadata.ssh.serial_port_enable
    ssh-keys           = var.vms_metadata.ssh.keys
    # На 6-ом задание больше не используется
    # ssh-keys           = "ubuntu:${file(var.vms_ssh_public_root_key)}"
  }

}
