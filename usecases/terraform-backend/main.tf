terraform {
  required_version = "~> 0.12.24"
  required_providers {
    aws = "~> 2.60.0"
  }
}

variable "region" {
  description = "state ファイル管理を行う region"
  type        = string
  default     = "ap-northeast-1"
}

variable "bucket" {
  description = "state ファイルを管理する S3 の bucket 名"
  type        = string
}

variable "dynamodb_table" {
  description = "state のロック管理用テーブル名"
  type        = string
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamodb_table
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "lock_id"

  attribute {
    name = "lock_id"
    type = "S"
  }
}
