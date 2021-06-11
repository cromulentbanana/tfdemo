resource "aws_s3_bucket" "xarvio-infra-codebuild" {
  bucket = "xarvio-infra-codebuild"
  acl    = "private"

  //  FIXME: introduce some check like this so production doesn't get its bucket
  //  removed on 'destroy': like force_destroy = ${var.stage} != "production"
  //  Since we're not running on production yet, we can investigate this in a follow-up issue.
  force_destroy = true
}

resource "aws_iam_role" "xarvio-infra-codebuild" {
  name = "xarvio-infra-codebuild"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "codebuild.amazonaws.com",
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

variable "stage" {
  default = "codebuild"
}

resource "aws_iam_role_policy" "xarvio-infra-codebuild" {
  role = "${aws_iam_role.xarvio-infra-codebuild.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "apigateway:DELETE",
        "apigateway:GET",
        "apigateway:PATCH",
        "apigateway:POST",
        "apigateway:PUT"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudformation:CancelUpdateStack",
        "cloudformation:ContinueUpdateRollback",
        "cloudformation:CreateStack",
        "cloudformation:DeleteStack",
        "cloudformation:DeleteStackSet",
        "cloudformation:DescribeChangeSet",
        "cloudformation:DescribeStackEvents",
        "cloudformation:DescribeStackResource*",
        "cloudformation:DescribeStacks",
        "cloudformation:ExecuteChangeSet",
        "cloudformation:GetStackPolicy",
        "cloudformation:GetTemplate",
        "cloudformation:ListChangeSets",
        "cloudformation:ListStackResources",
        "cloudformation:UpdateStack",
        "cloudformation:ValidateTemplate"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudwatch:GetDashboard",
        "cloudwatch:DeleteDashboards",
        "cloudwatch:ListDashboards",
        "cloudwatch:PutDashboard"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:CreateTable",
        "dynamodb:DeleteTable",
        "dynamodb:DescribeTable",
        "dynamodb:DescribeTimeToLive",
        "dynamodb:TagResource",
        "dynamodb:UpdateTimeToLive"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AllocateAddress",
        "ec2:AssociateRouteTable",
        "ec2:AttachInternetGateway",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CreateInternetGateway",
        "ec2:CreateNatGateway",
        "ec2:CreateNetworkInterface",
        "ec2:CreateNetworkInterfacePermission",
        "ec2:CreateRoute",
        "ec2:CreateRouteTable",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSubnet",
        "ec2:CreateTags",
        "ec2:CreateVpc",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeInstances",
        "ec2:DescribeRouteTables",
        "ec2:DescribeAddresses",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeNatGateways",
        "ec2:DeleteInternetGateway",
        "ec2:DeleteNatGateway",
        "ec2:DeleteNetworkInterface",
        "ec2:DeleteRoute",
        "ec2:DeleteRouteTable",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSubnet",
        "ec2:DeleteVpc",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeInternetGateways",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs",
        "ec2:DetachInternetGateway",
        "ec2:DisassociateRouteTable",
        "ec2:ModifyVpcAttribute",
        "ec2:ReleaseAddress",
        "ec2:RevokeSecurityGroupIngress",
        "ec2:RunInstances",
        "ec2:TerminateInstances"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetAuthorizationToken",
        "ecr:GetDownloadUrlForLayer",
        "ecr:GetLifecyclePolicy",
        "ecr:GetLifecyclePolicyPreview",
        "ecr:GetRepositoryPolicy",
        "ecr:ListImages",
        "ecr:ListTagsForResource"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "events:DeleteRule",
        "events:DescribeRule",
        "events:ListTargetsByRule",
        "events:PutRule",
        "events:PutTargets",
        "events:RemoveTargets"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:AttachRolePolicy",
        "iam:CreateRole",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:DetachRolePolicy",
        "iam:GetPolicy",
        "iam:GetRole",
        "iam:ListAttachedRolePolicies",
        "iam:ListPolicies",
        "iam:ListRolePolicies",
        "iam:ListRoles",
        "iam:PutRolePolicy",
        "iam:UpdateRole",
        "iam:PassRole",
        "iam:TagRole"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:CreateGrant",
        "kms:Decrypt"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "lambda:AddPermission",
        "lambda:CreateEventSourceMapping",
        "lambda:CreateFunction",
        "lambda:DeleteEventSourceMapping",
        "lambda:DeleteFunction",
        "lambda:DeleteLayerVersion",
        "lambda:Get*",
        "lambda:InvokeFunction",
        "lambda:List*",
        "lambda:PublishLayerVersion",
        "lambda:PublishVersion",
        "lambda:RemovePermission",
        "lambda:TagResource",
        "lambda:PutFunctionConcurrency",
        "lambda:UntagResource",
        "lambda:Update*"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:DeleteLogGroup",
        "logs:DeleteLogStream",
        "logs:DeleteRetentionPolicy",
        "logs:DeleteSubscriptionFilter",
        "logs:DescribeLogGroups",
        "logs:PutLogEvents",
        "logs:PutMetricFilter",
        "logs:PutSubscriptionFilter"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "rds:CreateDBCluster",
        "rds:CreateDBInstance",
        "rds:CreateDBSubnetGroup",
        "rds:DeleteDBCluster",
        "rds:DeleteDBInstance",
        "rds:DeleteDBSubnetGroup",
        "rds:DescribeDBClusters",
        "rds:DescribeDBInstances",
        "rds:DescribeDBSubnetGroups",
        "rds:DescribeEngineDefaultClusterParameters",
        "rds:DescribeEngineDefaultParameters"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:CreateBucket",
        "s3:DeleteBucket",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion",
        "s3:GetBucketLocation",
        "s3:GetBucketPolicy",
        "s3:GetLifecycleConfiguration",
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:ListBucket",
        "s3:ListBucketVersions",
        "s3:PutBucketNotification",
        "s3:PutBucketPolicy",
        "s3:PutBucketPublicAccessBlock",
        "s3:PutEncryptionConfiguration",
        "s3:PutLifecycleConfiguration",
        "s3:PutObject"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "sqs:CreateQueue",
        "sqs:DeleteQueue",
        "sqs:GetQueueAttributes",
        "sqs:TagQueue"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ],
      "Resource": [
        "arn:aws:ssm:*:*:parameter/global/api/*",
        "arn:aws:ssm:*:*:parameter/global/infra/*",
        "arn:aws:ssm:*:*:parameter/global/apigateway/*",
        "arn:aws:ssm:*:*:parameter/global/codepipeline/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "glue:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

variable "codebuild_deploy_project_name" {
  default = "xarvio-build-deploy"
}

variable "codebuild_functional_test_project_name" {
  default = "xarvio-build-functional-test"
}

variable "codebuild_cleanup_project_name" {
  default = "xarvio-build-cleanup"
}

resource "aws_codebuild_project" "xarvio-build-deploy" {
  name          = "${var.codebuild_deploy_project_name}"
  description   = "Deploy the xarvio application to ${var.stage}"
  build_timeout = "30"
  service_role  = "${aws_iam_role.xarvio-infra-codebuild.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.xarvio-infra-codebuild.bucket}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    #TODO: Replace this hard-coded registry URI with a dynamically generated URI
    image                       = "${var.aws_account_id}.dkr.ecr.eu-central-1.amazonaws.com/xarvio-base-image:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codebuild_deploy_project_name}-log"
      stream_name = "${var.codebuild_deploy_project_name}-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.xarvio-infra-codebuild.id}/build-log"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec-deploy.yml"
    git_clone_depth = 1
  }

  tags = {
    ManagedByTerraform = "True"
  }
}

resource "aws_codebuild_project" "xarvio-build-functional-test" {
  name          = "${var.codebuild_functional_test_project_name}"
  description   = "Run functional test"
  build_timeout = "45"
  service_role  = "${aws_iam_role.xarvio-infra-codebuild.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.xarvio-infra-codebuild.bucket}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "564924077059.dkr.ecr.eu-central-1.amazonaws.com/xarvio-base-image:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codebuild_functional_test_project_name}-log"
      stream_name = "${var.codebuild_functional_test_project_name}-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.xarvio-infra-codebuild.id}/build-log"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec-tests.yml"
    git_clone_depth = 1
  }

  tags = {
    ManagedByTerraform = "True"
  }
}

resource "aws_codebuild_project" "xarvio-build-cleanup" {
  name          = "${var.codebuild_cleanup_project_name}"
  description   = "Remove unnecessary resources"
  build_timeout = "20"
  service_role  = "${aws_iam_role.xarvio-infra-codebuild.arn}"

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.xarvio-infra-codebuild.bucket}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "564924077059.dkr.ecr.eu-central-1.amazonaws.com/xarvio-base-image:latest"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.codebuild_cleanup_project_name}-log"
      stream_name = "${var.codebuild_cleanup_project_name}-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${aws_s3_bucket.xarvio-infra-codebuild.id}/build-log"
    }
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec-cleanup.yml"
    git_clone_depth = 1
  }

  tags = {
    ManagedByTerraform = "True"
  }
}
