# DevOps Exam
***

The exam is presented in the form of independently performed laboratory work followed by its defense. Each defense has 20 minutes of time.

## Task:

Build a working infrastructure with automatic building and deplooping of a new version of the application using dockerization. As an application, develop 2 **web** applications that output "Hello World 1" & "Hello World 2" in languages from the list:

- Python
- .NET Core
- PHP
- Java
- Go (gin framework)

## Given:

- Ci/CD - you choose your own.
- SCM/ControlVersion - your choice (git based).
- Registry - your choice.
- Infrastructure - your choice.

## Result:

A finished lab that you can demonstrate. A presentation to defend the solution. The presentation should include 2 diagrams:

- How the Ci/CD process in your solution is structured,
- how you would build it in an ideal world and with no time constraints on the task. The presentation should include an infrastructure diagram.

## Additional advantages in solving the problem:

- Checking code with an analyzer such as snyk, sonarqube, linter, etc.
- Notification of results
- Automatic pipeline startup on commit/merge request
- Secret management
- Pipeline as code
- Container policy in docker registry (scheduled deletions etc)
- Utilization of logging services
- Checking application's automatic tests (if implemented)
- Write README.md

## Project repositories:

* [Repo project_web1](https://github.com/Xarakipi/project_web1)
* [Repo project_web2](https://github.com/Xarakipi/project_web2)

## Work environment:

* IaaS in the cloud, based on VMWare vCloud Director, NSX-V and several Public IPs.
* VM template created in the cloud with a clean Ubuntu 20.04 Server. The template integrates ssh public key
* GitHub repositories where all the necessary files and applications are stored
* Ubuntu 21.04 Desktop workstation with installed and configured:
  - Git and set up a connection to your account via GPG Key
  - Terraform and a module for vCloud Director
  - Ansible and configured its "/etc/ansible/hosts"
  - Jenkins with access from the internet
* Cup of coffee ☕

------

### Deploy project

------

#### 1. [Project_TerraForm](https://github.com/Xarakipi/TIL/tree/main/exam/project_terraform)

#### 2. Jenkins

* Access from internet on port 8080
* Install Docker with Jenkins server. Jenkins user with docker access.
* Docker plugins for jenkins
  * Docker
  * Docker pipeline
  * CloudBees Docker Hub/Registry Notification
* Configure Docker Hub/Registry credentials and create ID.

* Create 2 Items(jobs) with pipeline in Jenkins for each project.
* 1 Item build Docker image from github project repo and push it to Docker Hub. 
  * Github webhook trigger.
* 2 Item deploy Docker image from Docker Hub to IaaS VM. 
  * Docker Hub webhook trigger.
* Jenkins pipeline scripts stored with project in github repo.

#### 3. Test that everything works

* Commit github changes in your application project_web1 or project_web2
* Watch how Jenkines builds the application and deploys to VMs in IaaS
* Open in your browser
  * http://'UbuntuVM1_IP' for project_web1 
  * http://'UbuntuVM2_IP' for project_web2
