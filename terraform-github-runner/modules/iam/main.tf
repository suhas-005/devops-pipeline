resource "aws_iam_role" "iam_role" {
  name               = var.iam_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "iam-policy" {
  role = aws_iam_role.iam_role.name
  # Just for testing purpose, don't try to give administrator access in production
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "github-runner-instance-profile"
  role = aws_iam_role.iam_role.name
}