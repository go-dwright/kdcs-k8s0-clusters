
provider "aws" {
  default_tags {
    tags = {
      OwnerEmail = "{{ your_email }}"
      ProjectOrPurpose = "KCDS muffin time workshop"
      Application = "kubernetes control plane"
      ExpirationDate = "2022-11-31"
    }
  }
}

resource "aws_key_pair" "admin" {
  key_name   = "kcds-muffin-time-controller"
  public_key = "{{ your_public_key }}"

  tags = {
    Name = "kcds-muffin-time-controller"
  }
}

resource "aws_instance" "controller" {
  count = 1
  ami           = "ami-0f540e9f488cfa27d" // Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
  instance_type = "t3.small"
  subnet_id = "subnet-0d938012516ca03a5" // kcds-muffin-time-workshop-subnet-public1-eu-west-2a
  security_groups = ["sg-096f163a05c2b91fd"]

  key_name = aws_key_pair.admin.key_name

  volume_tags = {
    Name = "kcds-muffin-time-controller-${count.index}"
    ServiceHours = "Mon-Fri_9am-6pm"
    OwnerEmail = "{{ your_email }}"
    ProjectOrPurpose = "KCDS muffin time workshop"
    Application = "kubernetes control plane"
    ExpirationDate = "2022-11-31"
  }

  tags = {
    Name = "kcds-muffin-time-controller-${count.index}"
    ServiceHours = "Mon-Fri_9am-6pm"
  }
}

output "ip_addresses" {
  value = aws_instance.controller.*.public_ip
}
