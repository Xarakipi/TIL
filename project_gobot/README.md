# GoBot project

***

## Task

***

* Write Telegram bot in Go language that will show my GitHub repository and tasks

* Bot must understand these 3 commands

```
/git - show my GitHub repository
/tasks - show list of tasks
/task# - show task, where # is a task number
```

## Bot usage

***

Open [@Project_GoBot](https://t.me/Project_GoBot)

* Enter /help - message with help and other commands

## How to make Telegram Bot

***

* Register new telergam bot with [@BotFather](https://t.me/botfather), get bot token

* Create list of commands(help, git, tasks, task). Type /setcommands in [@BotFather](https://t.me/botfather)

* Create virtual machine (e.g. Ubuntu 20.04 Server)

* Install golang

  ```
  # apt install golang
  ```

* Get Go API

  ```
  # go get github.com/Syfaro/telegram-bot-api
  ```

* Create bot project dir

* Create bot config file