# Project Animals
***
Remote host requirements and preparation:
Fresh installed Debian 10 minimal and SSH Server with users: 'root'+password and 'debian'+password
====================================
You must use your user instead 'debian'
====================================
Local host preparation:
Installed python3 and pip3
Installed ansible
Add Remote host(IP) to ansible servers list '/etc/ansible/hosts'
====================================
## Unprepared servers. By default, Debian 10 minimal server doesn't have "sudo" and ssh access for 'root'. Default first user 'debian' doesn't have sudo access.
## If Debian 10 minimal installed without password for root you can skip this step
[firstservers]
fserver1 ansible_host=Deb10_IP

[firstservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user=debian

## Prepared servers. Servers with installed "sudo". Added user 'debian' to 'sudo'.
[readyservers]
rserver1 ansible_host=Deb10_IP

[readyservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_become=yes
ansible_user=debian
====================================
Copy your SSH keys to Remote host
$ ssh-copy-id debian@Deb10_IP
====================================
Test ansible connection to fresh Deb10 server.
$ ansible fserver1 -m ping

The results should look something like this:
Deb10_IP | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
====================================
## Download and use hostprepare.yml
====================================
Test ansible connection after hostprepare.yml
$ ansible rserver1 -m ping

The results should look something like this:
Deb10_IP | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
====================================
