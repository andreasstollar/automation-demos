# VMWare Tips and Tricks

## Set up Inventory

Use Localhost default inventory, all plays run on the Ansible Controller and use the API on vcenter to perform operations. At the top of all playbooks, these values must be set, hosts: all does not match localhost, so you need to be specific:

```
---
- hosts: localhost
  gather_facts: no
  connection: local
  tasks:
```

See Set Up Credentials Section for specifics on host to connect to VCEnter


## Set Up Credentials
- Create Machine Credential. Resources->Credential->Create New
	- Org: Default: Credential Type: Machine
Use a valid account that can connect to VCenter

Note: The VMWare collections appear to be migrating from vmware.vmware_rest to vmware.vmware. These two collections use different names for variables as follows:

### For vmware.vmware_rest set credentials like this:

```
      vcenter_hostname: vcenter.fqdn
      vcenter_username: "{{ ansible_user }}"
      vcenter_password: "{{ ansible_password }}"
      vcenter_validate_certs: false
```

### For vmware.vmware set credentials like this:

```
      hostname: vcenter.fqdn
      username: "{{ ansible_user }}"
      password: "{{ ansible_password }}"
      validate_certs: false
```

## Update Collections

Running 'ansible-galaxy' on the host installs collections to local users collections, but does nothing for Tower/Automation Platform. Use requirements.yml

### Create 'collections/requirements.yml'

```
---
collections:
  # Install a collection from Ansible Galaxy
  - name: vmware.vmware_rest
  - name: vmware.vmware
    version: "=1.11.0"
```

## Create Template
- Create Template. Resources->Templates->Create New
	- Organization: Default
	- Inventory: Localhost
	- Project: Repository You Are Using, set branch here if testing
	- Execution Environment: Default
	- Playbook: Choose playbook, note you might need to sync the Project before you see files in the pulldown


