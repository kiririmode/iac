variable "service_access_principals" {
  description = "Organization と統合する AWS サービス名のリスト"
  # TODO: aws organizations list-aws-service-access-for-organization 取得できるようであれば、説明に加える
  type = list(string)

  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]
}

variable "audit_root_email" {
  description = "監査用アカウントのメールアドレス"
  type        = string
}

variable "service_accounts" {
  description = "作成するサービス用アカウントのリスト"
  type = map(object({
    email = string
  }))
  default = {}
}
