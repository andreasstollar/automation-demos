## Quick Start 
A few notes to get started with Ansible Tower

### Add users and groups
Mostly self explanitory. Understand roles.

### Create Organization
Access -> Organizations. Click "+" in upper right, fill out fields.  

### Create Project
Resources -> Projects. Click "+" in upper right, fill out fields. This requires a repo to connect to. Its pretty smart and will look for playbooks in subdirectories of a repo. For example adding [this repo](https://github.com/andreasstollar/automation-demos) it found the ansible stuff, ignoring the terraform code.

### Create Credentials
Resources -> Credentials. Click "+" in upper right, select creditial type "Machine" for using ssh key auth.

### Create Inventory
1. Resources -> Inventory. Click "+" in upper right, fill out name and description, click "save"
1. Click "Hosts" button, add hosts

### Create Template
1. Resources -> Templates. Click "+" in upper right, fill out name, description, job type, inventory, project, playbook, credentials. Other fields are optional.