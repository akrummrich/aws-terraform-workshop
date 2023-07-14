## Versioning explanation
# see also https://learn.hashicorp.com/tutorials/terraform/versions#terraform-version-constraints
# | required_version  | meaning                                           |
# |-------------------|---------------------------------------------------|
# | "1.1.0"           | only terraform v1.1.0 exactly                     |
# | ">= 1.1.0"        | any terraform v1.1.0 or greater                   |
# | "~> 1.1.0"        | any terraform v1.1.x, but not v1.2 or later       |
# | ">= 1.1, < 2.0.0" | terraform v1.1.0 or greater, but less than v2.0.0 |
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws" 
      version = "~>4.26.0" 
    }
  }
  backend "s3" {
    bucket         = "ak-tf-workshop-2023"  
    key            = "workshop-ak.tfstate"   
    region         = "eu-central-1"        
    dynamodb_table = "ak-tf-workshop-2023-backend-lock" 
  }
}

provider "aws" {

} 