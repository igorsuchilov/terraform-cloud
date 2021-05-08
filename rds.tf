# resource "aws_db_instance" "default" {
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   engine               = "mysql"
#   engine_version       = "5.7"
#   instance_class       = "db.t2.micro"
#   name                 = "mydb"
#   username             = "admin"
#   password             = "admin1234"
#   parameter_group_name = "default.mysql5.7"
#   db_subnet_group_name = aws_db_subnet_group.db_subnet.name
#   skip_final_snapshot  = true
#   multi_az             = "true"
# }

resource "aws_security_group" "myapp_mysql_rds" {
  name        = "secuirty_group_web_mysqlserver"
  description = "Allow access to MySQL RDS"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "rds_secuirty_group"
  }

}

resource "aws_security_group_rule" "security_rule" {
  security_group_id = aws_security_group.myapp_mysql_rds.id
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"

  cidr_blocks = [
    var.vpc_cidr,
  ]
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "rds_subnet_group"
  subnet_ids = [aws_subnet.private_2[0].id, aws_subnet.private_2[1].id]
  tags = {
    Name = "rds_subnet_group"
  }
}
