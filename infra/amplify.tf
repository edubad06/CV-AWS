resource "aws_amplify_app" "cv_app" {
  name         = "cv-app"
  repository   = var.repo_url
  access_token = var.github_token

  environment_variables = {
    API_URL = "${aws_apigatewayv2_api.http_api.api_endpoint}/count"
  }

}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.cv_app.id
  branch_name = "main"

  enable_auto_build = true
}
