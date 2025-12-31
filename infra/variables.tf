variable "github_token" {
  description = "Personal Access Token for GitHub"
  type        = string
  sensitive   = true
}

variable "repo_url" {
  description = "URL of the GitHub repository"
  type        = string
  default     = "https://github.com/edubad06/CV-AWS"
}

variable "domain_name" {
  description = "Root domain name for the AWS Hosted Zone config"
  type        = string
  default     = "aws10.asix2a25-26.cat"
}

variable "subdomain" {
  description = "Subdomain for the CV"
  type        = string
  default     = "cv"
}

variable "cloudflare_api_token" {
  description = "API Token for Cloudflare to manage DNS"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Zone ID in Cloudflare where the NS records should be added"
  type        = string
}
