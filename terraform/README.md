# Terraform

This is a small collection of templates. Mostly the instructions on getting set up, taken from [here](https://learn.hashicorp.com/terraform/getting-started/intro) and [here](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180) Will update with specifics for other clouds when tested. 

## Getting Started
Terraform is powerful and feature rich, but getting started is fairly easy. You can follow the guide linked above to create a virtualbox instance. Or follow this guide and go directly to spinning up cloud instances, currently in AWS, Azure specific instructions coming soon.

1. Install terraform. Download appropriate package for your OS [here](https://www.terraform.io/downloads.html) Mac users may use [Homebrew](https://brew.sh/) and `brew install terraform`. Windows users may use [Chocolatey](https://chocolatey.org/) and `choco install terraform`
2. Create sample template, see file [`example.tf`](example.tf) in this directory, adjust AMI and ssh_keys as appropriate and place in a unique directory. The file can have any name, but should be the only file in the directory before running `terrarform init`
3. Set up AWS credentals. If you not done so, get your Access Keys. Go to AWS Console Services -> Security, Identity, & Compliance -> IAM. Select your user, and go to the 'Security credentials' tab. Select 'Create access key' make sure you save your key, it can NOT be displayed again. If you already created a key, but don't have it, you must create a new one.
4. Put the access keys in `~/.aws/credentials` formatted like this:<br>
`[default]`<br>
`aws_access_key_id = <key_id_here>`<br>
`aws_secret_access_key = <secret_access_key_here>`
5. Configure user permissions, need these.<br>
**AmazonEC2FullAccess**: required for this blog post.<br>
**AmazonS3FullAccess**: required for How to manage Terraform state.<br>
**AmazonDynamoDBFullAccess**: required for How to manage Terraform state.<br>
**AmazonRDSFullAccess**: required for How to create reusable infrastructure with Terraform modules.<br>
**CloudWatchFullAccess**: required for Terraform tips & tricks: loops, if-statements, and pitfalls.<br>
**IAMFullAccess**: required for Terraform tips & tricks: loops, if-statements, and pitfalls.
6. Test and launch. `terrform init` and `terraform apply` 
7. Check instances in the console, log in if you can.
8. Terminiate instances with `terraform destroy`
