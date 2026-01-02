# Ansible Installation and Configuration

## Install Ansible

It is much easier to grab the software from the rpm repos. Using the guide here:
https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.5/html/containerized_installation/

```
## install ansible-core
[root@ops-ansible-02 opt]# sudo dnf install -y ansible-core
....
Complete!
## optional tools -- recommended
[root@ops-ansible-02 opt]# sudo dnf install -y wget git-core rsync vim
....
Complete!
## create non-root user, and set up sudo, we will use 'aap'
[root@ops-ansible-02 opt]# adduser aap
[root@ops-ansible-02 opt]# passwd aap
New password:
Retype new password:
passwd: password updated successfully
## download software from https://access.redhat.com/downloads/content/480/ver=2.6/rhel---10/2.6/x86_64/product-software
## scp to target machine, put in /home/aap
## expand tarball, edit inventory file
[aap@ops-ansible-02 ~]$ tar zxf ansible-automation-platform-containerized-setup-2.6-4.tar.gz
[aap@ops-ansible-02 ~]$ cd ansible-automation-platform-containerized-setup-2.6-4## copy inventory file from documentation, edit hostname and set passwords and registry user and passphrase
## run the installer as an ansible playbook. This failed first time due to dbus errors, need to login as user 'aap' (NOT su - app, or sudo per https://access.redhat.com/solutions/7090808)
[aap@ops-ansible-02 ansible-automation-platform-containerized-setup-2.6-4]$ ansible-playbook -i inventory ansible.containerized_installer.install
... lots of output, started at 10:55 AM finished 11:11 AM (third attempt)
## had to set some variables for SSL certs in the inventory file, then re-ran installer.
custom_ca_cert=/home/aap/aap/tls/ca_ccu_loc.pem
gateway_tls_cert=/home/aap/aap/tls/tower.pem
gateway_tls_key=/home/aap/aap/tls/tower.key
controller_tls_cert=/home/aap/aap/tls/tower.pem
controller_tls_key=/home/aap/aap/tls/tower.key
hub_tls_cert=/home/aap/aap/tls/tower.pem
hub_tls_key=/home/aap/aap/tls/tower.key
eda_pg_tls_cert=/home/aap/aap/tls/tower.pem
eda_pg_tls_key=/home/aap/aap/tls/tower.key


```

## OLD ##
```
# yum install ansible-core
# yum install postgresql-server
# postgresql-setup --initdb
# passwd postgres # set to 'pg_password' in inventory file
# systemctl enable postgresql
# systemctl start postgresql
# mkdir /var/log/tower
# download ansible tarball, expand
# edit inventory file
-> setup required ssh-keygen, add pub key to authorized_keys (it sshs to itself)
# ./setup.sh (this took quite some time 10:02 start 10:23 end)
```

## Set Up Credentials
- Resources->Credential->Create New
	- Org: Default ; Credential Type: Source Control
	- Login to Azure devops Repo which required Duo MFA. Select 'clone' then create credentials, it gave me a password token that would work without Duo MFA. NOTE: This expired after a few weeks and had to be recreated. 
- Create Windows Machine Credential. Resources->Credential->Create New
	- Org: Default: Credential Type: Machine
- Create Linux Machine Credential. Resources->Credential->Create New
	- Org: Default: Credential Type: Machine

## Create Project
- Resources->Projects->Add
	- Name: Set a Unique Name
	- Description: Set as appropriate
	- Organizaion: Default
	- Execution Environment: Default
	- Source Control Type: Git (works for Azure Devops)
	- Source Control Url: https://CCUDevOps@dev.azure.com/CCUDevOps/DevOps/_git/AnsibleInfraPlaybooks
	- Source Control Branch/Tag/Commit: Set to branch or master
	- Source Control Credentail: Use Source Control Credential from previous section
	- Options: 'Update Revision on Launch' is very handy, leave others unchecked

## Create windows inventory, set up variables

Use Windows Credentials, and you only have to set these variables at the Inventory Level

```
---
  ansible_connection: psrp
  ansible_port: 5985 ## psrp encrypts over HTTP
```

## Edit Settings->Miscellaneous System Settings

Set base URL of service correctly, defaults to https://towerhost

## Clone Git. Get GIT credential as described above, copy the password, then the URL, change the username of the https url to be your username: e.g:
```
git clone https://v_andreass@dev.azure.com/CCUDevOps/DevOps/_git/AnsibleInfraPlaybooks/
```

## Update Collections

Running 'ansible-galaxy' on the host installs collections to local users collections, but does nothing for Tower/Automation Platform. Use requirements.yml

### Create 'collections/requirements.yml'

At base of repository that you are using for ansible, create directory 'collections' and create file 'requirements.yml' as follows -- this resolved missing win_feature_info module due to older ansible.windows collection.

```
---
collections:
  # Install a collection from Ansible Galaxy
  - name: ansible.windows
    version: "=2.8.0"
```
### Tips for ansible-galaxy

Everything is in a virtual environment. Setting path manually works, but each play creates its own cache, so use 'requirements.yml' as described above. This is what is looks like after using the requirements.yaml file

```
[root@OPS-ANSIBLE-01 /]# ansible-galaxy collection list -p /var/lib/awx/.local/share/containers/storage/overlay/549389c379d3a9a097d76c17a1c9abe708844ff23e424959fa894d3f0a7d4d98/diff/usr/share/ansible/collections/ansible_collections/ |grep windows
ansible.windows                 1.14.0
[root@OPS-ANSIBLE-01 /]# ansible-galaxy collection list -p /var/lib/awx/projects/.__awx_cache/_8__azure_devops_andreas_test_branch/10/requirements_collections/ansible_collections/

# /var/lib/awx/projects/.__awx_cache/_8__azure_devops_andreas_test_branch/10/requirements_collections/ansible_collections
Collection      Version
--------------- -------
ansible.windows 2.8.0
```

### SSL Certificates

For containerized installs set the keys and certs in the inventory file and re-run the installer
```
custom_ca_cert=/home/aap/aap/tls/ca_ccu_loc.pem
gateway_tls_cert=/home/aap/aap/tls/tower.pem
gateway_tls_key=/home/aap/aap/tls/tower.key
controller_tls_cert=/home/aap/aap/tls/tower.pem
controller_tls_key=/home/aap/aap/tls/tower.key
hub_tls_cert=/home/aap/aap/tls/tower.pem
hub_tls_key=/home/aap/aap/tls/tower.key
eda_pg_tls_cert=/home/aap/aap/tls/tower.pem
eda_pg_tls_key=/home/aap/aap/tls/tower.key
```
Then re-run the installer:
```
[aap@ops-ansible-02 ansible-automation-platform-containerized-setup-2.6-4]$ ansible-playbook -i inventory ansible.containerized_installer.install
```


# OLD
SSL Certs are pulled from the host vm at /etc/tower/tower.key and /etc/tower/tower.cert. To add signed certs simply copy valid cert and key to these files and restart the controller service with:

```
automation-controller-service restart
```
