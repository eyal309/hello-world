terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 2.13.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

resource "docker_image" "flask_test" {
  name         = "eyal309/flask_test:latest"
  keep_locally = true
}

resource "docker_container" "flask_test" {
  image = docker_image.flask_test.latest
  name  = "hello_world"
  ports {
    internal = 8080
    external = 80
  }
}

