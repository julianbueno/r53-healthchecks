
data "terraform_remote_state" "pagerduty" {
  backend = "s3"

  config = {
    region = "eu-west-1"
    bucket = "${var.cluster_name}-account-state"
    key    = "${var.pagerduty_workload_module_path}/terraform.tfstate"
  }
}

resource "aws_sns_topic" "sns-r53-healthcheck-topics" {
  for_each          = var.monitored_domains
  name              = "sns-r53-healthcheck-pd-topic-${each.key}"
  kms_master_key_id = aws_kms_key.healthchecks-topic-key.arn
}

resource "aws_sns_topic_subscription" "aws-rds-sns-subscriptions" {
  for_each  = var.monitored_domains
  topic_arn = aws_sns_topic.sns-r53-healthcheck-topics[each.key].arn
  protocol  = "https"

  endpoint = "https://events.pagerduty.com/integration/${data.terraform_remote_state.pagerduty.outputs.technical-services-output[each.key].integration_key}/enqueue"
}
