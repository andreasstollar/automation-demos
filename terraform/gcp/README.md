# GCP Terraform Collection
Here are a few examples to get started launching terraform instances in GCP.

## Files
`variables.tf` - variables referenced in other .tf files

`vpc.tf` - creates VPC, Subnets and Firewalls

`linux_instance.tf` - creates linux vm
(need some network instance scripts)

## Authentication
Set up credentials
https://cloud.google.com/docs/authentication/getting-started
create service account, and download .json key, store on your laptop in location below

export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/GDT_compute_svc_acct.json"

## Basic Usage
Copy `variables.tf`, `main.tf`, and one of the instance files to a temporary directory. Update variables as needed, then run:

`terraform init`

`terraform plan`, and then if passes and looks good

`terraform apply`

To shut it all down, run `terraform destroy` in the same temp directory. 


## Tips, Traps and Tricks

### Download and Install Google SDK
Not recreating those docs here, see https://cloud.google.com/sdk/docs/downloads-versioned-archives

Mac users can use brew `brew install google-cloud-sdk`

### Find image to use
This looks for ubuntu images, adjust as needed:
`gcloud compute images list |grep ubuntu`

```
NAME                                    PROJECT         FAMILY                  DEPRECATED      STATUS
ubuntu-1604-xenial-v20200908            ubuntu-os-cloud ubuntu-1604-lts                         READY
ubuntu-1804-bionic-v20200908            ubuntu-os-cloud ubuntu-1804-lts                         READY
ubuntu-2004-focal-v20200907             ubuntu-os-cloud ubuntu-2004-lts                         READY
ubuntu-minimal-1604-xenial-v20200908    ubuntu-os-cloud ubuntu-minimal-1604-lts                 READY
ubuntu-minimal-1804-bionic-v20200908    ubuntu-os-cloud ubuntu-minimal-1804-lts                 READY
ubuntu-minimal-2004-focal-v20200907     ubuntu-os-cloud ubuntu-minimal-2004-lts                 READY
```

Use PROJECT and FAMILY in terraform script

### Use bastion host, multiple internal networks
Some good instructions on setting up full VPC, subnets and firewalls
https://medium.com/slalom-technology/a-complete-gcp-environment-with-terraform-c087190366f0
