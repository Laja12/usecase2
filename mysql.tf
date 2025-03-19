


# Step 2: Create Subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-south-1a"  # Availability zone 1
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-south-1b"  # Availability zone 2
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-2"
  }
}

# Step 3: Create a DB Subnet Group (RDS Subnet Group)
resource "aws_db_subnet_group" "example" {
  name        = "example-subnet-group"
  description = "RDS DB Subnet Group"
  subnet_ids  = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  tags = {
    Name = "rds-subnet-group"
  }
}

# Step 4: Create the RDS MySQL Instance and associate the subnet group
resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "exampledb"
  username             = "admin"
  password             = "password1234"  # Secure password management is recommended
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  multi_az             = false
  publicly_accessible  = false
  backup_retention_period = 7
  db_subnet_group_name = aws_db_subnet_group.example.id
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  tags = {
    Name = "mysql-private-rds"
  }
}

# Step 5: Create a Security Group for the RDS instance
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main_vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["10.0.0.0/16"]  # Allow access from the entire VPC
    from_port   = 3306  # MySQL port
    to_port     = 3306
    protocol    = "tcp"
  }

  tags = {
    Name = "rds-security-group"
  }
}


