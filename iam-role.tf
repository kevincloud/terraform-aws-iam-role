data "aws_iam_policy_document" "module-assume-role" {
    statement {
        effect  = "Allow"
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "module-access-doc" {
    statement {
        sid       = "FullAccess"
        effect    = "Allow"
        resources = ["*"]

        actions = [ var.actions ]
    }
}

resource "aws_iam_policy" "module-access-doc" {
    name = "module-access-policy-${var.identifier}"
    policy = data.aws_iam_policy_document.module-access-doc.json
}

resource "aws_iam_role" "module-access-role" {
  name               = "module-access-role-${var.identifier}"
  assume_role_policy = data.aws_iam_policy_document.module-assume-role.json
}

resource "aws_iam_role_policy_attachment" "module-access-policy" {
  role   = aws_iam_role.module-access-role.id
  policy_arn = aws_iam_policy.module-access-doc.arn
}

resource "aws_iam_instance_profile" "main-profile" {
  name = "module-access-profile-${var.identifier}"
  role = aws_iam_role.module-access-role.name
}
