resource "aws_s3_bucket" "terraform_state_cicd" {
  bucket = "cloudcamp-terraform-state-001"
}

terraform {
  backend "s3" {
    bucket         = "cloudcamp-terraform-state-cicd"
    key            = "prod-cloudcamp/terraform.tfstate"
    region         = "us-east-1"
  }
}
