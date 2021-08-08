package main

import (
        "github.com/Syfaro/telegram-bot-api"
        "log"
        "regexp"
        "strconv"
)
var git = [8]string{"https://github.com/Xarakipi/TIL/tree/main/AboutMySelf",
    "https://github.com/Xarakipi/TIL/tree/main/TIL",
    "https://github.com/Xarakipi/TIL/tree/main/project_animals",
    "https://github.com/Xarakipi/TIL/tree/main/project_netstat",
    "https://github.com/Xarakipi/TIL/tree/main/project_gobot",
    "https://github.com/Xarakipi/TIL/tree/main/project_github",
    "https://github.com/Xarakipi/TIL/tree/main/project_docker",
    "https://github.com/Xarakipi/TIL/tree/main/exam",
}
func main() {
        // use a token and create a new bot instance
        bot, err := tgbotapi.NewBotAPI("1716773983:AAFJYUajRLjdfwHMeBdTRVATzv4fGKjXlW0")
        if err != nil {
                log.Panic(err)
        }
        log.Printf("Authorized on account %s", bot.Self.UserName)
        // u - structure with the config to get updates
        u := tgbotapi.NewUpdate(0)
        u.Timeout = 60
        // using config u to create a channel in which new messages will be sent
        updates, err := bot.GetUpdatesChan(u)
        // structures like Update arrive in the Updates channel
        // read them and process them
        for update := range updates {
                // response to any message
                reply := "I don't know what to say to that...\nI'll go ask the creator for instructions.\nIn the meant>
                if update.Message == nil {
                        continue
                }
                // logging what message came from whom
                log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)
                // switch to process commands
                // command - a message starting with "/"
                switch update.Message.Command() {
                case "help":
                        reply = "I know commands:\n/help - message with help and other commands\n/git - show my GitHub>
                case "git":
                        reply = "https://github.com/Xarakipi/TIL"

                case "tasks":
                        reply = "The list of tasks:\nTask 1. About Myself\nTask 2. Today i learned\nTask 3. Project An>
                }
                // checking the message for similarity task#
                taskx, _ := regexp.MatchString("/task[1-8]", update.Message.Text)
                if taskx {
                     // get the value # from the message task#
                     taskcount, _ := strconv.Atoi(string(update.Message.Text[len(update.Message.Text)-1]-1))
                     // send the task# value to the bot
                     msg := tgbotapi.NewMessage(update.Message.Chat.ID, git[taskcount])
                     bot.Send(msg)
                     reply = ""
                }
                // create a reply message
                msg := tgbotapi.NewMessage(update.Message.Chat.ID, reply)
                // sending
                bot.Send(msg)
        }
}
