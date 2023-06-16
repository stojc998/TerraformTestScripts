resource "aws_key_pair" "dove-key" {
  key_name = "dovekey"
  public_key = file("dovekey.pub") //file prebere kaj je v dovekey.pub in shrani vsebino v public_key
}

resource "aws_instance" "dove-inst" {
  ami = var.AMIS[var.REGION]
  instance_type = "t2.micro"
  availability_zone = var.ZONE1
  key_name = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-0b966d877b5ba1ef2"]
  tags = {
    Name = "Dove-Instance"
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
    private_key = file("dovekey")
    host = self.public_ip //povemo terraformu da uporabi public ip od instance, ki smo jo ustvarli in da uporabi tega uporabnika in kljuca
  }
}