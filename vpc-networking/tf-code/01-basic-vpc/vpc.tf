/* Resources to create */
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.default_name_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.default_name_tag
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.default_name_tag}-Private-RT"
  }
}

resource "aws_subnet" "public_subnets" {
  count                   = length(data.aws_availability_zones.available.names)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 10 + count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.default_name_tag}-${upper(data.aws_availability_zones.available.zone_ids[count.index])}-Public"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(data.aws_availability_zones.available.names)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.vpc.cidr_block, 8, 20 + count.index)

  tags = {
    Name = "${var.default_name_tag}-${upper(data.aws_availability_zones.available.zone_ids[count.index])}-Private"
  }
}

resource "aws_route_table_association" "private_rt_associations" {
  route_table_id = aws_route_table.private_rt.id
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
}

resource "tls_private_key" "rsa_keys" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_key_pair" "sydney_kp" {
  public_key = tls_private_key.rsa_keys.public_key_openssh
  key_name   = "sydney-kp2"
}
