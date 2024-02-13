# aws-route53

This module can be used to create route53 healthchecks in AWS.
----
## Usage
----

```
terraform {
  source = "git::git@"
}

inputs = {
  hosted_zone_domain  = "${get_env("CLUSTER_NAME")}.yourdomain.com"
  cluster_name        = get_env("CLUSTER_NAME")
  workload_account_id = get_env("AWS_ACCOUNT_ID")
  monitored_domains = {
    "exxchainge-fe" = {
      "name"   = "your-fe"
      "domain" = "www.yourdomain.com"
      "path"   = "/healthcheck"
    },
    "exxchainge-be" = {
      "name"   = "your-be"
      "domain" = "api.yourdomain.com"
      "path"   = "/actuator/health"
    }
  }
}

```



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.cw-alarm-healthcheck-fails](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_kms_alias.healthchecks-topic-key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.healthchecks-topic-key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_route53_health_check.r53-healthchecks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_health_check) | resource |
| [aws_sns_topic.sns-r53-healthcheck-topics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.aws-rds-sns-subscriptions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_iam_policy_document.cloudwatch_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.owner_and_cloudwatch_policy_merge](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.owner_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.pagerduty](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | AWS EKS cluster name of workloads | `any` | n/a | yes |
| <a name="input_evaluation_periods"></a> [evaluation\_periods](#input\_evaluation\_periods) | Number of periods needed for an alarm to fail and trigger an event | `string` | `"5"` | no |
| <a name="input_failure_threshold"></a> [failure\_threshold](#input\_failure\_threshold) | Interval in which the healthcheck will run against the monitored domains | `string` | `"5"` | no |
| <a name="input_monitored_domains"></a> [monitored\_domains](#input\_monitored\_domains) | n/a | `map(map(string))` | <pre>{<br>  "dummykey": {<br>    "dummykey": "dummyval"<br>  }<br>}</pre> | no |
| <a name="input_period"></a> [period](#input\_period) | Length of a period an alarm takes to check for failures | `string` | `"60"` | no |
| <a name="input_request_interval"></a> [request\_interval](#input\_request\_interval) | Interval in which the healthcheck will run against the monitored domains | `string` | `"30"` | no |
| <a name="input_workload_account_id"></a> [workload\_account\_id](#input\_workload\_account\_id) | The AWS account of workload | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK —>
