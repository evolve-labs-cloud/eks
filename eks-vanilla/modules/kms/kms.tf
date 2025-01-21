resource "aws_kms_key" "main" {
  description = var.prefix
}

resource "aws_kms_alias" "main" {
  name          = format("alias/%s", var.prefix)
  target_key_id = aws_kms_key.main.id
}
