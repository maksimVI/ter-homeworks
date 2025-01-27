resource "yandex_compute_instance" "db" {
    for_each = {
        for vm in var.each_vm:
          	vm.vm_name => vm
    }
    
    name        = each.value.vm_name
    platform_id = var.vm_platform
    zone        = var.default_zone

    resources {
        cores           = each.value.cpu
        memory          = each.value.ram
        core_fraction   = each.value.core_fraction
    }
    
    boot_disk {
       initialize_params {
         image_id   = data.yandex_compute_image.ubuntu.image_id
         size       = each.value.disk_volume
       }
    }
    
    scheduling_policy {
        preemptible = true
    }
    
    network_interface {
        subnet_id = yandex_vpc_subnet.develop.id
        nat       = true
        security_group_ids = [yandex_vpc_security_group.example.id]
    }

    metadata = {
        serial-port-enable = local.metadata.serial-port-enable
        ssh-keys           = local.metadata.ssh-keys
    }
}