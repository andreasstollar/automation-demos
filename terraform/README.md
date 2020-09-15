# Terraform

This is a small collection of templates. Mostly the instructions on getting set up, taken from [here](https://learn.hashicorp.com/terraform/getting-started/intro) and [here](https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180) Will update with specifics for other clouds when tested. 

## Getting Started
Terraform is powerful and feature rich, but getting started is fairly easy. You can follow the guide linked above to create a virtualbox instance. Or follow this guide and go directly to spinning up cloud instances, currently in AWS, Azure specific instructions coming soon.

1. Install terraform. Download appropriate package for your OS [here](https://www.terraform.io/downloads.html) Mac users may use [Homebrew](https://brew.sh/) and `brew install terraform`. Windows users may use [Chocolatey](https://chocolatey.org/) and `choco install terraform`
1. Copy some sample files to a temporary directory. The file(s) can have any name, all files in the directory with a `.tf` extension will be executed when terraform is run.
1. Set up credentals. See README.md in each cloud provider directory
1. Test and launch. `terrform init` and `terraform plan`, if it all looks good, then run `terraform apply` 
1. Check instances in the console, log in if you can.
1. Terminiate instances with `terraform destroy`
