resource "local_file" "hugo_api_url" {
  content = <<-EOT
  window.API_URL = "${aws_apigatewayv2_api.http_api.api_endpoint}/count";
  EOT
  filename = "${path.module}/site-built/static/js/api_url.js"
}
