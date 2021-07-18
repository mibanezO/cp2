variable "vm_size"{
	type = string
	description = "Tamaño de la máquina virtual"
	default = "Standard_D1_v2" # 3.5 GB, 1 CPU
}

variable "envs" {
	type = list(string)
	description = "Entornos"
	default = ["dev", "pre"]
}

variable "vms" { #listado de maquinas virtuales a generar
	type = list(string)
	description = "Máquinas Virtuales"
	default = ["master", "worker01", "worker02", "nfs"]
}

