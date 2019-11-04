resource "aws_cloudwatch_log_group" "hirayama-test" {
  name = "hirayama-test"
  retention_in_days = "3"

}