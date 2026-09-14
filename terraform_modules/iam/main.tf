locals {
  role_name     = var.name
  standard_tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_iam_role" "this" {
  count = var.create_iam_role ? 1 : 0

  name                  = local.role_name
  assume_role_policy    = var.assume_role_policy
  description           = var.description
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.iam_role_tags,
  )
}

resource "aws_iam_policy" "this" {
  count = var.create_iam_policy ? 1 : 0

  name        = local.role_name
  description = var.description
  policy      = var.policy

  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.iam_policy_tags,
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.create_iam_role_policy_attachment && var.create_iam_role && var.create_iam_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.this[0].arn
}
