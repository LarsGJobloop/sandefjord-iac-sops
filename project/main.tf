terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.6.0"
    }
  }
}

provider "github" {
  token = var.github_token
}

variable "github_token" {
  description = "The API token for GitHub"
  type = string
  sensitive = true
}

resource "github_repository" "this_repository" {
  name = "sandefjord-iac-sops"
  description = "Walktrough of how to use IaC and SOPS for defining projects"
}

resource "github_repository_collaborators" "name" {
  repository = github_repository.this_repository.name

  user {
    username = "lillian24sfj"
  }

  user {
    username = "Pacolomoreno"
  }
}

output "project" {
  value = github_repository.this_repository.html_url
}
