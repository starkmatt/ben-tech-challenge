terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# API GATEWAY RESOURCES
#
resource "aws_api_gateway_rest_api" "api" {
  name = "health"
}

resource "aws_api_gateway_resource" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "health"
}

resource "aws_api_gateway_method" "api" {
  authorization = "NONE"
  http_method   = "GET"
  resource_id   = aws_api_gateway_resource.api.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_integration" "api" {
  http_method = aws_api_gateway_method.api.http_method
  resource_id = aws_api_gateway_resource.api.id
  rest_api_id = aws_api_gateway_rest_api.api.id
  type        = "MOCK"
}

resource "aws_api_gateway_deployment" "api" {
  rest_api_id = aws_api_gateway_rest_api.api.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api.id,
      aws_api_gateway_method.api.id,
      aws_api_gateway_integration.api.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api" {
  deployment_id = aws_api_gateway_deployment.api.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "dev"
}

# ECR RESOURCES
#
resource "aws_ecr_repository" "ecr" {
  name = "${var.appname}-${var.environment}-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false # Would set to true for release candidate
  }
}

# Might not be necessary since github actions can return the ecr registry url
resource "aws_ssm_parameter" "ecr" {
  name  = "/${var.appname}/${var.environment}/ecr-url"
  type  = "String"
  value = "${aws_ecr_repository.ecr.repository_url}"
}

# ECS RESOURCES
#
resource "aws_ecs_cluster" "ecs" {
  name = "${var.appname}-${var.environment}-ecs-cluster"
}

resource "aws_ecs_task_definition" "ecs" {
  family = "health-api"
  container_definitions = jsonencode([
    {
      name      = "${var.appname}-${var.environment}-ecs-health-api"
      image     = aws_ecr_repository.ecr.repository_url
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 256
  memory = 512
  execution_role_arn = aws_iam_role.ecs.arn
}

resource aws_iam_role ecs {
  name = "ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs.json
  # assume_role_policy = <<EOF
  # {
  #   "Version": "2012-10-17",
  #   "Statement": [
  # {
  #     "Action": "sts:AssumeRole",
  #     "Principal": {
  #       "Service": "ecs-tasks.amazonaws.com"
  #     },
  #     "Effect": "Allow",
  #     "Sid": "*"
  # }
  # ]
  # }
  # EOF
}

data "aws_iam_policy_document" ecs {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}