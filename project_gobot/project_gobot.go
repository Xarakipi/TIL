package main

import (
        "github.com/Syfaro/telegram-bot-api"
        "log"
        "regexp"
        "strconv"
)
var git = [5]string{"https://github.com/Xarakipi/TIL/tree/main/AboutMySelf",
    "https://github.com/Xarakipi/TIL/tree/main/TIL",
    "https://github.com/Xarakipi/TIL/tree/main/project_animals",
    "https://github.com/Xarakipi/TIL/tree/main/project_netstat",
    "https://github.com/Xarakipi/TIL/tree/main/project_gobot",
}
func main() {
        // use a token and create a new bot instance
        bot, err := tgbotapi.NewBotAPI("TOKEN")
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
                reply := "I don't know what to say to that...\nI'll go ask the creator for instructions.\nIn the meantime, use /help."
                if update.Message == nil {
                        continue
                }
                // logging what message came from whom
                log.Printf("[%s] %s", update.Message.From.UserName, update.Message.Text)
                // switch to process commands
                // command - a message starting with "/"
                switch update.Message.Command() {
                case "help":
                        reply = "I know commands:\n/help - message with help and other commands\n/git - show may GitHub repository\n/tasks - show list of tasks\n/task# - show task, where # is a task number"
                case "git":
                        reply = "https://github.com/Xarakipi/TIL"

                case "tasks":
                        reply = "The list of tasks:\nTask 1. About Myself\nTask 2. Today i learned\nTask 3. Project Animals\nTask 4. Project netstat\nTask 5. Project GoBot"
                }
                // checking the message for similarity task#
                taskx, _ := regexp.MatchString("/task[1-5]", update.Message.Text)
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
