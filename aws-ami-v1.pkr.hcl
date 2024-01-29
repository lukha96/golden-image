# packer puglin for AWS 
# https://www.packer.io/plugins/builders/amazon 
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# which ami to use as the base and where to save it
source "amazon-ebs" "ubuntu" {
  region          = "ap-southeast-2"
  ami_name        = "ami-ubuntu-{{timestamp}}"
  instance_type   = "t2.micro"
  source_ami      = "ami-d38a4ab1"
  ssh_username    = "ubuntu"
  ami_users       = ["905418466161","975049922814", "905418411858"]
  ami_regions     = [
                      "us-east-1",
                      "ap-southeast-2",
                      "eu-central-1"
                    ]
}

# what to install, configure and file to copy/execute
build {
  name = "hq-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
  source = "provisioner.sh"
  destination = "/tmp/provisioner.sh"
}

# https://www.packer.io/docs/provisioners/shell 
provisioner "shell" {
    inline = ["chmod a+x /tmp/provisioner.sh"]
  }

  provisioner "shell" {
    inline = ["/tmp/provisioner.sh"]
  }
}
