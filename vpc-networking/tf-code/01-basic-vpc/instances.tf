/* Instances to create */
resource "aws_instance" "test-box" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.sydney_kp.key_name

  subnet_id = aws_subnet.public_subnets[0].id
}