# Multi-Tier RDS Hierarchy
This example show how you can create Multi-Tier RDS Hierarchy using Terraform

## Usage
To run this example you need to execute:

```bash 
$ terraform init -backend-config="bucket=${s3_bucket_name}" -backend-config="region=${aws_region}" -backend-config="key=${file_path_in_s3_bucket}.tfstate"
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | => 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | => 4.7  |
