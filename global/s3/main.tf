/*This is the classic "chicken and egg" situation. I want to store my state files in an S3 bucket, I want to provision
 the bucket using terraform and set terraform to use S3 as a backend.

 Disable the terraform config starting at line 51, create the bucket and the table.
 Enable the config block, call terraform init again and terraform apply to store the state file in the S3 bucket.*/

provider "aws" {
  region = "eu-west-2"
}

# Create an S3 bucket to enable remote state storage with S3
resource "aws_s3_bucket" "terraform_state_files" {

  # Bucket name - only lowercase alphanumeric characters and hyphens allowed. The name has to be unique!
  bucket = "unq-9613826-terraform-state-files"

  # Enable versioning
  versioning {
    enabled = true
  }

  # Prevent accidental deletion
  lifecycle {
    prevent_destroy = true
  }

  /*Enable encryption using AES to ensure that your state files, and the secrets they contain, are always encrypted
  on disk when stored in S3*/
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# Create a DynamoDB table to hold file locks
resource "aws_dynamodb_table" "tf_locks" {
  hash_key = "LockID"

  # Table name - must satisfy regular expression pattern: [a-zA-Z0-9_.-]
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

terraform {

  /* The backend block does not allow any variables. Be extra cereful if you copy&paste to another module!
     If you won't change the key you will overwrite the state of the other module. */
  backend "s3" {

    # The name of the bucket created for storing state files
    bucket = "unq-9613826-terraform-state-files"

    # The "file path" within the S3 bucket
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-2"

    #The DynamoDB table to use for locking
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
