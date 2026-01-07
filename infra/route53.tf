resource "aws_route53_zone" "main" {
  name = var.domain_name
}

resource "aws_amplify_domain_association" "domain" {
  app_id                = aws_amplify_app.cv_app.id
  domain_name           = var.domain_name
  wait_for_verification = true

  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = var.subdomain
  }

  depends_on = [cloudflare_record.ns_delegation]
}

output "amplify_default_domain" {
  value = "main.${aws_amplify_app.cv_app.id}.amplifyapp.com"
}

output "nameservers" {
  value = aws_route53_zone.main.name_servers
}
