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

## Описание рабочей среды:

* Есть IaaS в облаке, на основе VMWare vCloud Director, NSX-V и несколько Public IP.
* В облаке создан шаблон ВМ с чистой ОС Ubuntu 20.04 Server. В шаблон интегрирован ssh public key
* GitHub репозитории, где хранятся необходимые для работы файлы и приложения
* Рабочее место с ОС Ubuntu 21.04 Desktop, где установлен и настроен:
  - Git и настроено подключение к своему аккаунту по GPG Key
  - Terraform и модуль для vCloud Director
  - Ansible и настроен его hosts
  - Jenkins с доступом из интернета
* Чашка кофе



------

### Deploy project

------

1. [Project_TerraForm](https://github.com/Xarakipi/TIL/tree/main/exam/project_terraform)
