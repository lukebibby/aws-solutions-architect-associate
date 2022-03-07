/* Instances to create */

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_security_group_rule" "allow_ssh_in_sg_rule" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "allow_http_out_sg_rule" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "allow_https_out_sg_rule" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_instance" "test-box" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  key_name = aws_key_pair.sydney_kp.key_name

  security_groups = [aws_security_group.public_sg.id]

  subnet_id = aws_subnet.public_subnets[0].id
}