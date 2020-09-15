# AWS Terraform Collection
Here are a few examples to get started launching terraform instances in AWS.

## Files
`variables.tf` - variables referenced in other .tf files

`vpc.tf` - creates VPC, Subnets and Firewalls

`linux_instance.tf` - creates linux vm, use with vpc.tf to create instance in new VPC

`arista_instance.tf` - creates arista vm, use with vpc.tf to create instance in new VPC

`cisco_instance.tf` - creates cisco vm, use with vpc.tf to create instance in new VPC

`junos_instance.tf` - creates juniper vm, use with vpc.tf to create instance in new VPC

`windows_instance.tf` - creates windows vm, use with vpc.tf to create instance in new VPC

## Authentication
1. Set up AWS credentals. If you not done so, get your Access Keys. Go to AWS Console Services -> Security, Identity, & Compliance -> IAM. Select your user, and go to the 'Security credentials' tab. Select 'Create access key' make sure you save your key, it can NOT be displayed again. If you already created a key, but don't have it, you must create a new one.
1. Put the access keys in `~/.aws/credentials` formatted like this:<br>
`[default]`<br>
`aws_access_key_id = <key_id_here>`<br>
`aws_secret_access_key = <secret_access_key_here>`
1. Configure user permissions, need these.<br>
**AmazonEC2FullAccess**: required for this blog post.<br>
**AmazonS3FullAccess**: required for How to manage Terraform state.<br>
**AmazonDynamoDBFullAccess**: required for How to manage Terraform state.<br>
**AmazonRDSFullAccess**: required for How to create reusable infrastructure with Terraform modules.<br>
**CloudWatchFullAccess**: required for Terraform tips & tricks: loops, if-statements, and pitfalls.<br>
**IAMFullAccess**: required for Terraform tips & tricks: loops, if-statements, and pitfalls.