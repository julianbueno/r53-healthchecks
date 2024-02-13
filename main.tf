
resource "aws_route53_health_check" "r53-healthchecks" {
  for_each          = var.monitored_domains
  fqdn              = each.value["domain"]
  port              = 443
  type              = "HTTPS"
  resource_path     = each.value["path"]
  failure_threshold = var.failure_threshold
  request_interval  = var.request_interval
  tags = {
    Name = "${each.value["name"]}-r53-pd-healthcheck"
  }
}

resource "aws_cloudwatch_metric_alarm" "cw-alarm-healthcheck-fails" {
  for_each            = var.monitored_domains
  alarm_name          = "${each.value["name"]}-r53-pd-healthcheck-failure"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = var.evaluation_periods
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = var.period
  statistic           = "Minimum"
  threshold           = "1"
  alarm_description   = "Monitor Route53 Health Checks"
  alarm_actions       = [aws_sns_topic.sns-r53-healthcheck-topics[each.key].arn]
  ok_actions          = [aws_sns_topic.sns-r53-healthcheck-topics[each.key].arn]
  dimensions = {

    "HealthCheckId" = aws_route53_health_check.r53-healthchecks[each.key].id
  }
  actions_enabled = "true"

}
