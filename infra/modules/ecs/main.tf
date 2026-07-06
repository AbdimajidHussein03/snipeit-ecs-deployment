resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  tags = {
    Name    = "${var.project_name}-cluster"
    Project = var.project_name
    Managed = "Terraform"
  }
}

resource "aws_cloudwatch_log_group" "snipe_it" {
  name              = "/ecs/${var.project_name}"
  retention_in_days = var.log_retention_days

  tags = {
    Name    = "/ecs/${var.project_name}"
    Project = var.project_name
    Managed = "Terraform"
  }
}

resource "aws_iam_role" "ecs_task_execution" {
  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name    = "${var.project_name}-ecs-task-execution-role"
    Project = var.project_name
    Managed = "Terraform"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "snipe_it" {

  family                   = "${var.project_name}-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  cpu    = var.task_cpu
  memory = var.task_memory

  execution_role_arn = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {

      name      = var.container_name
      image     = "${var.ecr_repository_url}:latest"
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "APP_ENV"
          value = "production"
        },
        {
          name  = "APP_DEBUG"
          value = "false"
        },
        {
          name  = "LOG_CHANNEL"
          value = "stderr"
        },
        {
          name  = "APP_URL"
          value = var.app_url
        },
        {
          name  = "APP_KEY"
          value = var.app_key
        },
        {
          name  = "DB_CONNECTION"
          value = "mysql"
        },
        {
          name  = "DB_HOST"
          value = var.db_host
        },
        {
          name  = "DB_PORT"
          value = tostring(var.db_port)
        },
        {
          name  = "DB_DATABASE"
          value = var.db_name
        },
        {
          name  = "DB_USERNAME"
          value = var.db_username
        },
        {
          name  = "DB_PASSWORD"
          value = var.db_password
        },
        {
          name  = "DB_SSL"
          value = "true"
        },
        {
          name  = "DB_SSL_IS_PAAS"
          value = "true"
        },
        {
          name  = "DB_SSL_CA_PATH"
          value = "/etc/ssl/certs/ca-certificates.crt"
        },
        {
          name  = "DB_SSL_VERIFY_SERVER"
          value = "false"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.snipe_it.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = {
    Name    = "${var.project_name}-task"
    Project = var.project_name
    Managed = "Terraform"
  }
}

resource "aws_ecs_service" "snipe_it" {

  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.snipe_it.arn

  desired_count = 1
  launch_type   = "FARGATE"

  health_check_grace_period_seconds = 300

  network_configuration {

    subnets          = var.private_subnet_ids
    security_groups  = [var.ecs_security_group_id]
    assign_public_ip = false
  }

  load_balancer {

    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  tags = {
    Name    = "${var.project_name}-service"
    Project = var.project_name
    Managed = "Terraform"
  }
}