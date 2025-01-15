variable "zone" {
  default     = "ru-central1-a"
  description = "YaCloud network zone"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4" /*Многострочный комментарий.
 Требуемая версия terraform */
}

provider "yandex" {

  /*
  Terraform считывает значение ENV переменной YC_TOKEN:
  
  // token      = export YC_TOKEN=$(yc iam create-token)  
  // cloud_id   = export YC_CLOUD_ID=$(yc config get cloud-id)
  // folder_id  = export YC_FOLDER_ID=$(yc config get folder-id)
  */

  zone = var.zone
}

resource "yandex_compute_image" "ubuntu_2404" {
  source_family = "ubuntu-2404-lts-oslogin"
}

resource "yandex_compute_disk" "boot-disk-vm1" {
  name     = "boot-disk-1"
  type     = "network-hdd"
  zone     = var.zone
  size     = "10"
  image_id = yandex_compute_image.ubuntu_2404.id
}

resource "yandex_compute_instance" "vm-1" {
  name        = "terraform1"
  hostname    = "terraform1"
  platform_id = "standard-v3" // standard-v2 — для архивных хостов на платформе Intel Cascade; standard-v3 — Lake Intel® Ice Lake
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 50 // Гарантированная доля vCPU — 5%
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-vm1.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = var.zone
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}