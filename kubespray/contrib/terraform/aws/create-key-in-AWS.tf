resource "aws_key_pair" "instance-ssh-key" {
  key_name   = "${var.AWS_SSH_KEY_NAME}"
  public_key = "${file("../../../key/${var.AWS_SSH_KEY_NAME}.pub")}"
}
