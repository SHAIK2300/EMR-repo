# terraform {
#   required_version = "~> 1.4" #it allows verisons 1.4 and greater than following 1.4.xx, 1.5.xx this chooses rifght most choice.
#   required_providers {
#     #Here AWS is passing as a required argument like mapping (for argument we are having '=' like aws = {},
#     # where for block eg: terraform {})
#     # this is the maim example of this
#    aws = {
#       source = "hashicorp/aws"
#       version = "4.60.0"
#     }
#   }
# }
# # provider "aws" {
# #   region = us-east-1
# #   #profile = default   #this is used when the profile means User is different and in case of default can ignore this line
# # }

# # resource "aws_instance" "sample" {


# # }
# # resource "aws_emr_cluster" "emr_cluster" {
# #   name          = "emr_cluster"
# #   release_label = "emr-5.29.0"
# #   service_role  = "EMR_DefaultRole"
# #   applications  = ["Spark"]
# #   job_flow_role = "EMR_EC2_DefaultRole"
# #   log_uri       = "s3://awsemrlogs-imran/logs/"

# #   master_instance_group {
# #     instance_type  = "m5.xlarge"
# #     instance_count = 1
# #   }

# #   core_instance_group {
# #     instance_type  = "m5.xlarge"
# #     instance_count = 2
# #   }

# #   # applications {
# #   #   name = "Spark"
# #   # }

# #   bootstrap_action {
# #     path = "s3://emr-imran-bucket/bootstrap.sh"
# #     name = "bootstrap"
# #     }

# #   configurations_json = <<EOF
# # [
# #   {
# #     "Classification": "spark",
# #     "Properties": {
# #       "maximizeResourceAllocation": "true"
# #     }
# #   }
# # ]
# # EOF
# # }

# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_emr_cluster" "emr" {
#   service_role   = "path.cwd"
#   name           = "my-emr-cluster"
#   release_label  = "emr-5.36.0"
#   applications   = ["Spark"]
#   instance_type  = "m5.xlarge"
#   instance_count = "3"
#   keep_job_flow_alive_when_no_steps = true

#   resource "aws_emr_instance_group" "task" {
#   cluster_id     = aws_emr_cluster.tf-test-cluster.id
#   instance_count = 1
#   instance_type  = "m5.xlarge"
#   name           = "my little instance group"
# }

#   master_instance_group { 
#     instance_type = "m5.xlarge"
#     instance_count = 1
#   }

#   core_instance_group {
#     instance_type = "m5.xlarge"
#     instance_count = 2
#   }

#   bootstrap_action {
#     path = "s3://emr-imran-bucket/inputfolder/bootstrap.sh"
#     name = "Bootstrap Spark"
#   }

#   configuration {
#     classification = "spark"
#     properties = {
#       "maximizeResourceAllocation" = "true"
#       "spark.dynamicAllocation.enabled" = "false"
#       "spark.executor.instances" = "6"
#       "spark.executor.memory" = "4g"
#       "spark.executor.cores" = "2"
#       "spark.default.parallelism" = "12"
#     }
#   }
# }


#  resource "aws_dynamodb_table" "demoDynamuDB" {
#    name           = "dynamoDB-table-state-lock1"
#    hash_key       = "LockID"
#    read_capacity  = 20
#    write_capacity = 20
#    attribute {
#      name = LockID
#      type = s
#    }
#    tags = {
#      "Name" = "dynamoDB-table-state-lock1"
#    }
#  }

terraform {
  required_version = "~> 1.4.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

#Provisionig EC2 instance
resource "aws_instance" "myec2" {
  ami                         = "ami-00c39f71452c08778"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  tags = {
    "Name" = "My_Ec2_instance"
  }
  
}

/*configuring terraform backend and storing 
Tfstate file in S3 Bucket*/
terraform {

  backend "s3" {
    bucket         = "terraform-statefileshaik"
    key            = "demo/tfstatefile" #"path/to/my/key"
    dynamodb_table = "dynamoDB-table-state-lock" 
    region         = "us-east-1"
  }
  required_version = ">= 0.12.0"
}
