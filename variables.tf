
variable "monitored_domains" {
  type = map(map(string))
  default = {
    "dummykey" = {
      "dummykey" = "dummyval"
    }
  }
}

variable "workload_account_id" {
  description = "The AWS account of workload"
}

variable "cluster_name" {
  description = "AWS EKS cluster name of workloads"
}

variable "evaluation_periods" {
  type        = string
  description = "Number of periods needed for an alarm to fail and trigger an event"
  default     = "5"
}

variable "pagerduty_workload_module_path" {
  type        = string
  description = "PagerDuty path of the workload module implemented(usually it's /pagerduty but it could also be /initiatives/zonnepanelen/pagerduty for example"
  default     = "pagerduty"
}

variable "period" {
  type        = string
  description = "Length of a period an alarm takes to check for failures"
  default     = "60"
}

variable "failure_threshold" {
  type        = string
  description = "Interval in which the healthcheck will run against the monitored domains"
  default     = "5"
}

variable "request_interval" {
  type        = string
  description = "Interval in which the healthcheck will run against the monitored domains"
  default     = "30"
}
