# Ansible project

***

## *You must use your user instead 'debian' and your IP instead 'Deb10_IP'*

***

### Remote host requirements and preparation:

Fresh installed Debian 10 minimal and SSH Server with users: 'root'+password and 'debian'+password

### Local host preparation:

Installed python3 and pip3

Installed ansible

***

Copy your SSH keys to Remote host

$ ssh-copy-id debian@Deb10_IP

***

Add Remote host(IP) to ansible servers list '/etc/ansible/hosts'

```
[firstservers]
fserver1 ansible_host=Deb10_IP

[firstservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user=debian

[readyservers]
rserver1 ansible_host=Deb10_IP

[readyservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_become=yes
ansible_user=debian
```

***

### Servers with or without sudo.

* By default, Debian 10 minimal server doesn't have "sudo" and ssh access for 'root'. Default first user 'debian' doesn't have sudo access.

* **If Debian 10 minimal installed without password for 'root' you should pass both tests without errors.**

Test 1. Ansible connection to fresh Deb10 server.

```
$ ansible fserver1 -m ping
```

The results should look something like this:

```
Deb10_IP | SUCCESS => {
    "changed": false,
    "ping": "pong"}
```

Test 2. Ansible connection to fresh Deb10 server.

```
$ ansible rserver1 -m ping
```

The results should look something like this if the server has sudo, otherwise there should be an error:

```
Deb10_IP | SUCCESS => {
    "changed": false,
    "ping": "pong"}
```

If you get an error on test 2, then download and run 

[hostprepare.yml](https://github.com/Xarakipi/TIL/blob/2c35f826d2c78abebaf7955beee1252ebf43bab9/project_animals/hostprepare.yml)

This ansible playbook install sudo and add user debian to sudoers

```
$ ansible-playbook hostprepare.yml --ask-become-pass
```
