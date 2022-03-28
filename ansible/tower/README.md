## Some differences between supported ansible and redhat ansible tower

### New -- add this stuff to ansible preso

ansible-galaxy now have collections, officially redhat supported modules 'automation_hub'
* allows for selection of community, vendor supported (e.g. cisco) or community modules
* can pin versions in the file `requirements.yml` 
* the cisco_ntp.yml playbook is an example of recommended way to use a collection using FQCN (fully qualified collection name)
** can set in playbooks using 'collections' top level, but preferred is the way done in cisco playbooks
** using `-vvv` will show exactly whether collections are being used or base modules.

## Maintiain collections -- Tower
see [https://docs.ansible.com/ansible-tower/3.8.0/html/userguide/projects.html#ansible-galaxy-support](https://docs.ansible.com/ansible-tower/3.8.0/html/userguide/projects.html#ansible-galaxy-support)

and [https://docs.ansible.com/ansible-tower/3.8.0/html/userguide/projects.html#collections-support](https://docs.ansible.com/ansible-tower/3.8.0/html/userguide/projects.html#collections-support)


## Maintiain collections -- open source
No easy upgrade all, need to do this:
```
andreasstollar@corundum:~/work/Repos/github/automation-demos/ansible$ ansible-galaxy collection list               

/Users/andreasstollar/.ansible/collections/ansible_collections
Collection        Version
----------------- -------
ansible.netcommon 1.4.1  
cisco.ios         1.1.0  
community.mysql   1.0.2  
andreasstollar@corundum:~/work/Repos/github/automation-demos/ansible$ ansible-galaxy collection install --force cisco.ios
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'cisco.ios:1.2.1' to '/Users/andreasstollar/.ansible/collections/ansible_collections/cisco/ios'
Downloading https://galaxy.ansible.com/download/cisco-ios-1.2.1.tar.gz to /Users/andreasstollar/.ansible/tmp/ansible-local-49637_i9gtq49/tmp_cf0ze2u
cisco.ios (1.2.1) was installed successfully
Skipping 'ansible.netcommon' as it is already installed
andreasstollar@corundum:~/work/Repos/github/automation-demos/ansible$ ansible-galaxy collection list                             

# /Users/andreasstollar/.ansible/collections/ansible_collections
Collection        Version
----------------- -------
ansible.netcommon 1.4.1  
cisco.ios         1.2.1  
community.mysql   1.0.2  
```
