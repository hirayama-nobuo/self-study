resource "aws_instance" "example" {
    ami = "ami-0064e711cbc7a825e"
    instance_type = "t2.micro"

    tags {
      Name = "hirayama-test-instance"
    }
}

resource "aws_eip" "ip" {
    vpc = true
    instance = "${aws_instance.example.id}"
}

resource "aws_s3_bucket" "example" { 
  bucket = "hirayama-test"
  acl    = "private"
}

resource "aws_instance" "another" {
  ami           = "ami-0064e711cbc7a825e"
  instance_type = "t2.micro"

  tags {
    Name = "hirayama-test-instance2"
  }

  depends_on = ["aws_s3_bucket.example"]

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}


