# GCP Terraform Collection
Here are a few examples to get started launching terraform instances in GCP.

## Files
`variables.tf` - variables referenced in other .tf files

`vpc.tf` - creates VPC, Subnets and Firewalls

`linux_instance.tf` - creates linux vm
(need some network instance scripts)

## CLI tools
Use gcloud console, or install tools locally. 

Local installs will need to use the authentication mechanism below.

On a mac.
```
brew install google-cloud-sdk
```

## Authentication
Set up credentials
https://cloud.google.com/docs/authentication/getting-started
### New method:
```
andreasstollar@corundum:~/work/terraform/gcp/rhel9$ gcloud auth login
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=32555940559.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=1UtZnPKMLGDRQ4LtvWm2btnCXt2AHr&access_type=offline&code_challenge=9v7inIjIZ7joU88lfoSAxOMqVpMD_ynFVbQawbyCDw0&code_challenge_method=S256


You are now logged in as [andreas.stollar@gdt.com].
Your current project is [awesome-tube-294518].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID


To take a quick anonymous survey, run:
  $ gcloud survey
```

### Below is older method
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

### GCP pricing
https://cloud.google.com/products/calculator
