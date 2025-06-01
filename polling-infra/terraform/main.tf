terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "polling_net" {
  name = "polling-network"
}

resource "null_resource" "frontend_build" {
  provisioner "local-exec" {
    command     = "docker build -t polling-frontend:latest ."
    working_dir = "C:/Users/berik/Desktop/Polling-App/polling-app-client/src"
  }
}

resource "null_resource" "backend_build" {
  provisioner "local-exec" {
    command     = "docker build -t polling-backend:latest ."
    working_dir = "C:/Users/berik/Desktop/Polling-App/polling-app-server"
  }
}

resource "null_resource" "polling_compose" {
  depends_on = [docker_network.polling_net, null_resource.frontend_build, null_resource.backend_build]
  provisioner "local-exec" {
    command     = "docker-compose up -d"
    working_dir = "C:/Users/berik/Desktop/Polling-App/polling-infra/terraform"
  }
}

output "frontend_url" {
  value = "http://localhost:3030"
}

output "backend_url" {
  value = "http://localhost:8080"
}

output "postgres_url" {
  value = "jdbc:postgresql://localhost:5432/dbhabit?currentSchema=srefinal"
}