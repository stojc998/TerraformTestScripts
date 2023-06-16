resource "aws_key_pair" "multiresource-key" {
  key_name = "multiresourcekey"
  public_key = file(var.PUB_KEY) //file prebere kaj je v dovekey.pub in shrani vsebino v public_key
}

resource "aws_instance" "multiresource-webapp" {
  ami = var.AMIS[var.REGION]
  instance_type = "t2.micro"
  subnet_id = aws_subnet.pub-subnet-1.id
  availability_zone = var.ZONE-USE1a
  key_name = aws_key_pair.multiresource-key.key_name
  vpc_security_group_ids = [aws_security_group.multiresource-sg.id]
  tags = {
    Name = "Multiresource-Instance"
    Project = "Dove"
  }

  provisioner "file" {
    //skopiramo datoteko web.sh v naso virtualko
    source = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    //naredimo datoteko, ki smo jo skopirali executable in jo pozenemo
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user = var.USER
    private_key = file(var.PRIV_KEY)
    host = self.public_ip //povemo terraformu da uporabi public ip od instance, ki smo jo ustvarli in da uporabi tega uporabnika in kljuca
  }
}//"aws_instance" "dove-inst"

resource "aws_ebs_volume" "vol-4-multires_webapp" {
  availability_zone = var.ZONE-USE1a
  size = 3
  tags = {
    Name = "extr-vol-4-multires_webapp"
  }
}//vol-4-multires_webapp

resource "aws_volume_attachment" "vol-4-multires_webapp-attach" {
  device_name = "/dev/xvdh"
  instance_id = aws_instance.multiresource-webapp.id
  volume_id = aws_ebs_volume.vol-4-multires_webapp.id
}//vol-4-multires_webapp-attach

//po tem ko se instance postavi si izpisemo privatni in javni ip
output "PrivateIP" {
  value = aws_instance.multiresource-webapp.private_ip
}

output "PublicIP" {
  value = aws_instance.multiresource-webapp.public_ip
}