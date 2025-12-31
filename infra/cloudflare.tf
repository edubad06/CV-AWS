resource "cloudflare_record" "ns_delegation" {
  count   = 4
  zone_id = var.cloudflare_zone_id
  name    = var.domain_name # This puts the full "aws10.asix2a25-26.cat" as the name. Cloudflare usually handles the relative part automatically or accepts FQDN.
  type    = "NS"
  content = aws_route53_zone.main.name_servers[count.index]
  ttl     = 3600
}
