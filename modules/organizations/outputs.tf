output "arn" {
  description = "Organizations自体のARN"
  value       = aws_organizations_organization.org.arn
}

output "accounts" {
  description = "Organizationsに含まれる全アカウント情報。マスターアカウントを含む"
  value       = aws_organizations_organization.org.accounts
}

output "master_account_arn" {
  description = "マスターアカウントのARN"
  value       = aws_organizations_organization.org.master_account_arn
}

output "master_account_id" {
  description = "マスターアカウントのID"
  value       = aws_organizations_organization.org.master_account_id
}
