#Security Group for Inspec Validation Server
  resource "aws_security_group" "VM_Image_Factory_Inspec_Validation_SG" {
  name        = "VM_Image_Factory_Inspec_Validation_SG"
  description = "Enable SSH access via port 22"
  vpc_id      = "${var.vw_vpc_id}"

#Inbound access from bamboo server
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vw_sg_source_cidr}"]
  }

#Outbound access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "VM_Image_Factory_Inspec_Validation_SG"
  }
}

#Creating the Inspec Validation Server for testing the Golden AMI created in Packer Build
resource "aws_instance" "VM_Image_Factory_Inspec_Validation" {
  ami = "${var.packer_ami_id}"
  associate_public_ip_address = "false"
  instance_type = "${var.vw_insttype}"
  subnet_id = "${var.vw_subnetid}"
  vpc_security_group_ids = ["${aws_security_group.VM_Image_Factory_Inspec_Validation_SG.id}"]
  tags {
      Name = "VM_Image_Factory_Inspec_Validation"
      Owner = "VM Image Factory"
          "Purpose" = "Temporary Instance creating for Inspec validation of Golden AMI"
  }
  user_data             = <<HEREDOC
#!/bin/bash -ex
useradd test
echo -e '${var.inspec_user_password}\n${var.inspec_user_password}\n' | sudo passwd test
sed -i -r 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "test ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
service sshd restart
HEREDOC

#Establishing connection with validation server to apply Inspec profile
  connection {
    type = "ssh"
    user = "test"
    password = "${var.inspec_user_password}"
  }

#Copies all inspec files to destination instance in temp directory
  provisioner "file" {
    source      = "../inspec/"
    destination = "/tmp/"
  }

#Install inspec dependancies and execute Inspec profile
  provisioner "remote-exec" {
    inline = [
      "sudo wget https://packages.chef.io/files/stable/inspec/2.0.17/ubuntu/16.04/inspec_2.0.17-1_amd64.deb",
      "sudo rm -rf /var/lib/dpkg/lock",
      "sudo dpkg -i inspec_2.0.17-1_amd64.deb",
      "sudo -i inspec exec /tmp/controls/ --no-color > /tmp/test.txt",
      "cat /tmp/test.txt"
    ]
  }
}
