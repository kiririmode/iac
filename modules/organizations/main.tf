
resource "aws_organizations_organization" "org" {
  aws_service_access_principals = var.service_access_principals

  # see: https://docs.aws.amazon.com/organizations/latest/APIReference/API_EnablePolicyType.html#API_EnablePolicyType_RequestSyntax
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY",
    "TAG_POLICY",
  ]

  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "core" {
  name      = "core"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "service" {
  name      = "service"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_account" "audit" {
  name      = "audit"
  email     = var.audit_root_email
  parent_id = aws_organizations_organizational_unit.core.id
}

/*
TODO: 監査用アカウントにログも集約すれば良い
resource "aws_organizations_account" "log" {
  name      = "log"

  parent_id = aws_organizations_organizational_unit.core.id
}
*/

resource "aws_organizations_account" "service_accounts" {
  for_each = var.service_accounts

  name      = each.key
  email     = each.value.email
  parent_id = aws_organizations_organizational_unit.service.id
}
