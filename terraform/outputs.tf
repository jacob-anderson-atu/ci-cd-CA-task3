output "instance_id" {
  description = "ID of the deployed EC2 instance"
  value       = aws_instance.pipeline.id
}

output "public_ip" {
  description = "Public IPv4 address of the instance0"
  value       = aws_instance.pipeline.public_ip
}

output "application_url" {
  description = "Public URL of the deployed application"
  value       = "http://${aws_instance.pipeline.public_ip}"
}