resource "aws_amplify_app" "cv_app" {
  name         = "cv-app"
  repository   = var.repo_url
  access_token = var.github_token

  # IAM Role removed: LabRole does not trust Amplify, and we don't need backend deployment privileges for static build.
  # iam_service_role_arn = data.aws_iam_role.lab_role.arn

  environment_variables = {
    API_URL = "${aws_apigatewayv2_api.http_api.api_endpoint}/count"
  }

  # build_spec removed to allow amplify.yml from repo to take precedence.

}

resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.cv_app.id
  branch_name = "main"

  enable_auto_build = true
}
