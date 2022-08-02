# Ansible

Ansible is an automation tool, really nothing more than a connection multiplexer that allows for management of a large number of hosts. 

This document is meant as a very quick start guide, mostly to be used in a training context. Please see the [full documentation](https://docs.ansible.com/ansible/latest/user_guide/index.html) for further details, or ask [your friendly neighborhood security and automation admin](andreas.stollar@gdt.com) 

## Set up workstation.
Linux and MacOS only. Ansible can control Windows hosts but [cannot run on windows](https://docs.ansible.com/ansible/latest/user_guide/windows_faq.html) 

1. Install Ansible. Mac `brew install ansible`, Linux `yum install ansible`(RedHat flavors), or `apt-get install ansible`(Debian flavors)
2. Create inventory. Default inventory is `/etc/ansible/hosts` however we will use the inventory file specified in ansible.cfg. Inventories can get very complex with groups and variables. 
3. Create a playbook. For initial testing, its good to do something harmless, like have the hosts print out their hostname before you try something potentially destructive.
4. Run the thing. If you are able to ssh to linux hosts, or have completed the setup for windows hosts, you can run ansible like this:<br>`ansible-playbook playbooks/hostname.yaml`
5. You can do a lot with `--limit` to limit the hosts that ansible will run on.<br>`ansible-playbook --limit windows playbooks/hostname.yaml`<br>where 'windows' is a defined group in `/etc/ansible/hosts`

## Manage Linux hosts
Pretty much need to make sure you can ssh to a host, and run sudo without a password.

## Manage Windows hosts
Used [this guide](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html) and [this one](https://argonsys.com/microsoft-cloud/articles/configuring-ansible-manage-windows-servers-step-step/)

* important part, run this in powershell, sets up winrm listener, creates a self signed cert, and adds firewall rule. Customers will typically be joined to a domain, look at windows_setup guide to see specific tests. If anyone wants to help faciliate some tests on windows host joined to a domain, [let me know](andreas.stollar@gdt.com)

```
$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file
```
* verify/get thumbprint of SSL cert

```
Get-ChildItem -path cert:\LocalMachine\My
```
* win2016 had powershell 5.1, left alone earlier versions may need some patches.
* installed .NET 4.8 from IE. (had to disable IE security) may be required for installation tasks, hostname test runs without.
* had to open up firewall rules in AWS. WinRM-HTTPS port 5986.
* had to run - `systempropertiesadvanced` to allow user other than 'Administrator' to run winrm commands.
* set up auth:

```
In the file:
playbooks/group_vars/windows ('windows' must match the group in the inventory file)

ansible_user: Administrator
ansible_password: <password>
ansible_port: 5986 (SSL port, self signed certs are no problem for ansible)
ansible_connection: winrm
ansible_winrm_server_cert_validation: ignore
```
* test connection from Linux host with python (sudo pip3 install pywinrm, or pip3 install winrmmanager on Mac)

```
andreas@ip-172-31-4-15:~/work$ python3
Python 3.8.2 (default, Apr 27 2020, 15:53:34) 
>>> import winrm
>>> session = winrm.Session('https://54.183.154.124:5986/wsman', auth=('Administrator','<REDACTED>'), server_cert_validation='ignore')
>>> result = session.run_ps("ipconfig")
>>> print(result.std_out)
b'\r\nWindows IP Configuration\r\n\r\n\r\nEthernet adapter Ethernet:\r\n\r\n   Connection-specific DNS Suffix  . : us-west-1.compute.internal\r\n   Link-local IPv6 Address . . . . . : fe80::a56b:7f6a:feb1:1484%4\r\n   IPv4 Address. . . . . . . . . . . : 172.31.12.118\r\n   Subnet Mask . . . . . . . . . . . : 255.255.240.0\r\n   Default Gateway . . . . . . . . . : 172.31.0.1\r\n\r\nTunnel adapter Local Area Connection* 3:\r\n\r\n   Connection-specific DNS Suffix  . : \r\n   IPv6 Address. . . . . . . . . . . : 2001:0:34f1:8072:20c3:2f9f:f2c6:b80\r\n   Link-local IPv6 Address . . . . . : fe80::20c3:2f9f:f2c6:b80%6\r\n   Default Gateway . . . . . . . . . : ::\r\n\r\nTunnel adapter isatap.us-west-1.compute.internal:\r\n\r\n   Media State . . . . . . . . . . . : Media disconnected\r\n   Connection-specific DNS Suffix  . : us-west-1.compute.internal\r\n'
```

## Tips, Traps and Tricks

#### Output all facts for a host, note that it doesn't seem to work against a host
```
ansible <HOSTGROUP> -m setup
```

#### Some info on ansible playbooks to set up an Illumio PCE
[https://docs.illumio.com/core/22.2/Content/LandingPages/Guides/ansible-playbooks-for-pce.htm](https://docs.illumio.com/core/22.2/Content/LandingPages/Guides/ansible-playbooks-for-pce.htm)

#### Convert .ini to .yml
```
ansible-inventory -i inventory.ini -y --list >inventory.yml
```

#### Use ansible-lint, install with brew or package manager
```
ansible-lint <playbook>
```

#### Mac OSX Users! Ansible may crash on you with an ugly error: 
```
objc[38892]: +[__NSCFConstantString initialize] may have been in progress in another thread when fork() was called. We cannot safely call it or ignore it in the fork() child process. Crashing instead. Set a breakpoint on objc_initializeAfterForkError to debug.```
To Resolve, disable Mac OS thread saftey with this `export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES`
