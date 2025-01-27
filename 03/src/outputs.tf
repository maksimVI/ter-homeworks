output "vm_web_and_vm_db" {
    value = concat(
        [for instance in yandex_compute_instance.web : {
            name    = instance.name,
            id      = instance.id,
            fqdn    = instance.fqdn
        }],
        [for instance in yandex_compute_instance.db : {
            name    = instance.name,
            id      = instance.id,
            fqdn    = instance.fqdn
        }]
    )
}