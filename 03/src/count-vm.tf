data "yandex_compute_image" "ubuntu" {
    family = var.vm_image
}

resource "yandex_compute_instance" "web" {
    depends_on = [yandex_compute_instance.db]
    count = 2
    name = "web-${count.index + 1}"
    platform_id = var.vm_platform
    zone = var.default_zone
    
    resources {
        cores           = var.vms_resources.cores
        memory          = var.vms_resources.memory
        core_fraction   = var.vms_resources.core_fraction
    }
    boot_disk {
       initialize_params {
         image_id   = data.yandex_compute_image.ubuntu.image_id
         size       = 10
       }
    }
    scheduling_policy {
        preemptible = true
    }
    network_interface {
        subnet_id           = yandex_vpc_subnet.develop.id
        nat                 = true
        security_group_ids  = [yandex_vpc_security_group.example.id] # id созданной группы безопасности
    }

    metadata = {
        serial-port-enable  = local.metadata.serial-port-enable
        ssh-keys            = local.metadata.ssh-keys
    }

    
}