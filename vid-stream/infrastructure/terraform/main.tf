# infrastructure/terraform/main.tf

provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "video_bucket" {
  bucket = "video-streaming-bucket"
  acl    = "public-read"
}

resource "aws_eks_cluster" "k8s_cluster" {
  name     = "video-streaming-cluster"
  role_arn = "arn:aws:iam::123456789012:role/EKS-Role"

  vpc_config {
    subnet_ids = ["subnet-abc123", "subnet-def456"]
  }
}

resource "aws_rds_instance" "db_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.3"
  instance_class       = "db.t2.micro"
  name                 = "videodb"
  username             = "admin"
  password             = "password"
  publicly_accessible  = true
  skip_final_snapshot  = true
}
