resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name = "hirayama-test"
  retention_in_days = "3"

}