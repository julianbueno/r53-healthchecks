resource "aws_kms_key" "healthchecks-topic-key" {
  description             = "Workload SNS Service Encryption Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.owner_and_cloudwatch_policy_merge.json
}

resource "aws_kms_alias" "healthchecks-topic-key" {
  name          = "alias/${var.cluster_name}-healthchecks-topic-key"
  target_key_id = aws_kms_key.healthchecks-topic-key.key_id
}

data "aws_iam_policy_document" "owner_policy" {
  statement {
    sid = "KeyOwnerPolicy"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.workload_account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}

// Construct the Users policy to define users/roles allowed to assume this role and use this Key
data "aws_iam_policy_document" "cloudwatch_policy" {
  statement {
    sid = "KeyCloudwatchPolicy"

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }

    actions = [
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "kms:Decrypt",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "owner_and_cloudwatch_policy_merge" {
  source_policy_documents = data.aws_iam_policy_document.owner_policy.json
  override_policy_documents = data.aws_iam_policy_document.cloudwatch_policy.json
}
