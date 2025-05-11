resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "Public-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_subnet" "Private-subnet" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "Private-Subnet"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "Public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "Public-rt"
  }
}

#routetable association
resource "aws_route_table_association" "Pub-sub" {
  route_table_id = aws_route_table.Public-rt.id
  subnet_id = aws_subnet.Public-subnet.id
}

resource "aws_route_table" "Private-rt" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "Private-rt"
  }
}

#Priavte route table association
resource "aws_route_table_association" "priv-sub" {
  route_table_id = aws_route_table.Private-rt.id
  subnet_id = aws_subnet.Private-subnet.id
}