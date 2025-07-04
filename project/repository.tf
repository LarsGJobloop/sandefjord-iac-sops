resource "github_repository" "this_repository" {
  name = "sandefjord-iac-sops"
  description = "Walktrough of how to use IaC and SOPS for defining projects"
}

output "project" {
  value = github_repository.this_repository.html_url
}
