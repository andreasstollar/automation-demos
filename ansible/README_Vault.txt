vault_pass: <you_wish>

create/edit vault file
ansible-vault create vaulted_vars.yml # this prompts for master vault password, store securely
ansible-vault edit vaulted_vars.yml
- create file with this format:
user_root:correcthorsebatterystaple
user_test:someotherpassword

then run with:
`ansible-playbook --limit ansible-tower.demo.gdt.com change_pass_vault.yml --ask-vault-pass` will prompt for vault pass

-- look into using user_vars for this. Some docs on using host_vars, but that seems dumb to me (pass should be consistent on all hosts)





RedHat Notes:
To put it simply, adduser is the command meant for the Linux user, and useradd is the command meant for system use. In technical terms, this means that adduser provides a high level interface for adding new users, and useradd provides a low level interface.
manually do:

