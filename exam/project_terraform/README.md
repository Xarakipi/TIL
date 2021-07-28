# Project TerraForm

***

## Terraforming a Planet for Dummies

Here I will tell you how to terraform the planet Mars

### Requirements:

* The bot factory as a service
* Bots template

### Creating and customizing bots

* Creating bots from template
* Assemble the bots using Ansible
* Jenkins for updating the firmware and software of the bots

Someday...

![](http://b.radikal.ru/b40/2107/5c/ea7d2c31a0d7.jpg)

But for now, let's start small - app with "Hello World!"


### Remote host requirements and preparation:

* IaaS vCloud Director from provider and parameters for vcd.tfvars

* Template Ubuntu 20.04 with integrated your ssh public keys

### Local host preparation:

- Installed terraform
- Installed [terraform-provider-vcd](https://github.com/vmware/terraform-provider-vcd.git)
- Installed ansible
- Download/clone project_terraform from git
- Configure vcd.tfvars in project_terraform

------

### Read and deploy

***

Add Remote host(IP) to ansible servers list '/etc/ansible/hosts'

```
[readyservers]
rserver1 ansible_host='UbuntuVM1_IP'
rserver2 ansible_host='UbuntuVM2_IP'

[readyservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_become=yes
ansible_user=ubuntu
ansible_become_pass='{{ ansible_sudo_pass }}'
```

------

Go to project_terraform directory and execute commands

```
terraform init
terraform apply -var-file=vcd.tfvars
```

Wait... Have a coffee ☕

Go to ansible directory

```
cd ./ansible/
```

Add ansible-vault for save sudo password of remote host(user 'ubuntu')

```
ansible-vault create passwd.yml
```

Set the password for vault. After providing a password, append the following('ubuntu' password)

```
ansible_sudo_pass: 'VeryStrongPassword'
```

Test ansible connection to fresh Ubuntu server.

```
ansible rserver1 -m ping --ask-vault-pass --extra-vars '@passwd.yml'
```

```
ansible rserver2 -m ping --ask-vault-pass --extra-vars '@passwd.yml'
```

The results should look something like this:

```
Deb10_IP | SUCCESS => {
    "changed": false,
    "ping": "pong"}
```

Then run ansible playbook.

```
ansible-playbook docker.yml --ask-vault-pass --extra-vars '@passwd.yml'
```

Finish your coffee... ☕

Done, you have a cloud infrastructure with deployed VMs and prepared to run docker containers in them

🐳🐳🐳
