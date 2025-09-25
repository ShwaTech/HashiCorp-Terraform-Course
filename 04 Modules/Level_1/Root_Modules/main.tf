

module "ec2_instance_1" {
  source = "../EC2_Module_1"
  count = 2
}

module "ec2_instance_2" {
  source = "./EC2_Module_2"
  count = 3
}

module "sg_module" {
  source = "../../Security_Modules/Sec_Grp_Module"
}

module "nacl_module" {
  source = "../../Security_Modules/NACL_Module"
}

