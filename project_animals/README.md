# Ansible project

***

## Create and deploy your own service
### The development stage:
For the true enterprise grade system we will need Python3, Flask and emoji support. Why on Earth would we create stuff that does not support emoji?!

* the service listens at least on port 80 (443 as an option)
* the service accepts GET and POST methods
* the service should receive `JSON` object and return strings in the following manner:
```sh
$ curl -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' http://myvm.localhost/
cow says moooo
cow says moooo
cow says moooo
Made with :heart: by %your_name

$ curl -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' http://myvm.localhost/
elephant says whoooaaa
elephant says whoooaaa
elephant says whoooaaa
elephant says whoooaaa
elephant says whoooaaa
Made with :heart: by %your_name
```
* bonus points for being creative when serving `/`

### Hints
* [installing flask](https://flask.palletsprojects.com/en/1.1.x/installation/#installation)
* [become a developer](https://flask.palletsprojects.com/en/1.1.x/quickstart/)
* [or whatch some videos](https://www.youtube.com/watch?v=Tv6qXtc4Whs)
* [dealing with payloads](https://www.digitalocean.com/community/tutorials/processing-incoming-request-data-in-flask)
* [Flask documentation](https://flask.palletsprojects.com/en/1.1.x/api/#flask.Request.get_json)
* [The database](https://emojipedia.org/nature/)
* 🐘 🐮 🦒
* what would you expect to see when visiting a random unknown website?

### The operating stage:
* create an ansible playbook that deploys the service to the VM
* make sure all the components you need are installed and all the directories for the app are present
* configure systemd so that the application starts after reboot
* secure the VM so that our product is not stolen: allow connections only to the ports 22,80,443. Disable root login. Disable all authentication methods except 'public keys'.
* bonus points for SSL/HTTPS support with self-signed certificates
* bonus points for using ansible vault

### Requirements
* Debian 10
* VirtualBox VM

***

## Read and deploy

***

## *You must use your user instead 'debian' and your IP instead 'Deb10_IP'*

***

### Remote host requirements and preparation:

Fresh installed Debian 10 minimal and SSH Server with users: 'root'+password and 'debian'+password

### Local host preparation:

* Installed python3 and pip3

* Installed ansible

* Installed svn

* Installed curl

* Ready ssh keys

***

Copy your SSH keys to Remote host

$ ssh-copy-id 'debian'@'Deb10_IP'

***

Add Remote host(IP) to ansible servers list '/etc/ansible/hosts'

```
[firstservers]
fserver1 ansible_host='Deb10_IP'

[firstservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_user='debian'

[readyservers]
rserver1 ansible_host='Deb10_IP'

[readyservers:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_become=yes
ansible_user='debian'
ansible_become_pass='{{ ansible_sudo_pass }}'
```

***
Download project from GitHub

```
$ svn export https://github.com/Xarakipi/TIL/trunk/project_animals
```

Go to folder 'project_animals'

```
$ cd ./project_animals
```

***

Add ansible-vault for save sudo password of remote host(user 'debian').

```
ansible-vault create passwd.yml
```

Set the password for vault. After providing a password, append the following('debian' password)

```
ansible_sudo_pass: 'VeryStrongPassword'
```

### Servers with or without sudo.

* By default, Debian 10 minimal server doesn't have "sudo" and ssh access with 'root'. Default first user 'debian' doesn't have "sudo" access.

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

Test 2. Ansible connection to fresh Deb10 server. (ansible vault file 'passwd.yml' password)

```
$ ansible rserver1 -m ping --ask-vault-pass --extra-vars '@passwd.yml'
```

The results should look something like this if the server has sudo, otherwise there should be an error:

```
Deb10_IP | SUCCESS => {
    "changed": false,
    "ping": "pong"}
```

If you get an error on test 2, then run [hostprepare.yml](https://github.com/Xarakipi/TIL/blob/2c35f826d2c78abebaf7955beee1252ebf43bab9/project_animals/hostprepare.yml)

This ansible playbook install sudo and add user 'debian' to sudoers

Remember to correct in the file hostprepare.yml at the line "command: usermod -aG sudo debian" the user 'debian' to your

Then run playbook.

```
$ ansible-playbook hostprepare.yml --ask-become-pass
or
$ ansible-playbook hostprepare.yml -K
```

"-K" = "--ask-become-pass"

Enter 'root' password for remote host.

Repeat 'test 2'. If the test is successful, go ahead

***

### Deploy project

***

```
ansible-playbook project_animals.yml --ask-vault-pass --extra-vars '@passwd.yml'
```

If the deployment went without errors, then you can test the work:

```

$ curl -k -XPOST -d'{"animal":"cow", "sound":"moooo", "count": 3}' https://'Deb10_IP'/


$ curl -k -XPOST -d'{"animal":"elephant", "sound":"whoooaaa", "count": 5}' https://'Deb10_IP'/

```

If the deployment was unsuccessful, then I don't know how to help ... In my lab everything worked without problems ❤️

P.s. Don't forget to look in your browser https://'Deb10_IP'/


## To Do

***

* Error messages with hints

* 
