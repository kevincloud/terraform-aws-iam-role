variable "identifier" { }
variable "actions" {
    type = list(string)
    default = [
        "ec2:*",
        "dynamodb:*",
        "ssm:UpdateInstanceInformation",
        "ssm:ListInstanceAssociations",
        "ssm:ListAssociations",
        "ssmmessages:CreateControlChannel",
        "ssmmessages:CreateDataChannel",
        "ssmmessages:OpenControlChannel",
        "ssmmessages:OpenDataChannel"
    ]
}
