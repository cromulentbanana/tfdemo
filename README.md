This repository contains a demonstrative terraform config intended to be used
as a practical introduction. It sets up an instance of the AWS codebuild
service.  The instructions below describe how it is used.

## Running terraform to instantiate the codepipeline/codebuild services
[Install terraform >=(0.12.10)](https://www.terraform.io/downloads.html) Ensure
you have your AWS Credentials exposed as ENV variables in the usual way. The
terraform workspace is using local state by default, but it can be configured
to use S3 for managing its remote state and dynamodb as a lock to prevent
concurrent invocations.

To run, in this directory:
```
# Initialize the terraform workspace (this is a one-time operation)
terraform init

# Create a plan and review the proposed changes
terraform plan -out tfplan

# Apply the plan
terraform apply tfplan

# Observe the output to ensure that all resources have been successfully created.

# Destroy all the terraform resources
terraform destroy
```
