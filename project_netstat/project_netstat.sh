#!/bin/bash

### Variables
# sudo_user - run script with sudo privileges or not
# name_pid - PID/Program name
# cname_pid - for check name_pid empty or not
# lines_number - number of output results
# x - for counter function lines_number
# wip - WhoIs IP
# wip2 - WhoIs IP with other requested information
# format - format of output results
# other_wip_info - other whois information
# xcommand - choise netstat or ss
# xpid - PID/Program name column in netstat or ss
# xip - IP column in netstat or ss
# xstate - Connection state column in netstat or ss
# xns - command netstat or ss with arguments
###
x=1
format="%-7s %-17s %-15s %-50s %s\n"
### Choice netstat or ss
printf "%s\n" "Which command do you want to use, 'netstat' or 'ss'(default 'netstat')?" "'1' for use 'netstat'" "'2' for use 'ss'"
read -p "Enter your choise number 1/2 (default 1 for 'netstat'): " xcommand
while ! [[ $xcommand = 1 || $xcommand = 2 || $xcommand = "" ]]
do
  read -p "Enter your choise number '1' for 'netstat' or '2' for 'ss': " xcommand
done
if [[ $xcommand = "2" ]]
  then
      xpid=7
      xip=6
      xstate=2
      xns="ss -4ap"
      echo "The command will be used 'ss'"
  else
      xpid=7
      xip=5
      xstate=6
      xns="netstat -tunapl"
      echo "The command will be used 'netstat'"
fi
### Privilege escalation request
printf "%s\n" "Run script from sudo user?" "You need root privileges to see all information"
read -p "Enter 'y' or 'n' (default n(No)): " sudo_user
### Replace uppercase letters with lowercase
sudo_user=$(echo $sudo_user | tr [[:upper:]] [[:lower:]])
### Checking that the response to the privilege escalation request is in the correct format
while ! [[ $sudo_user = y || $sudo_user = n || $sudo_user = "" ]]
do
  read -p "Enter 'y' for Yes or 'n' for No): " sudo_user
done
if [[ $sudo_user = "y" ]]
  then
      sudo_user=sudo
      sudo echo "Script run with root privileges"
  else
      sudo_user=""
fi
### Ask for the name or PID of the program
read -p "Enter PID/Program name: " name_pid
### Replace uppercase letters with lowercase
name_pid=$(echo $name_pid | tr [[:upper:]] [[:lower:]])
### Checking the existence of the requested process
if [[ ! -z $name_pid ]]
  then
      cname_pid=$($sudo_user $xns 2>/dev/null | awk '/'$name_pid'/ {print $'$xpid'; exit}')
      if [[ ! -z $cname_pid ]]
        then
### Request number of output results
            read -p "Enter number of output results: " lines_number
        else
            echo "Program or PID '$name_pid' not found"
            exit 1
      fi
  else
      echo "Program name or PID cant be null"
      exit 2
fi
### Checking for the contents of letters in a variable
while ! [[ $lines_number =~ ^[0-9]+$ ]]
do
  echo "Sorry, integers only"
  read -p "Enter correct number of output lines: " lines_number
done
### Other WhoIs information
printf "%s\n" "Want to see other WhoIs information?" "You need to enter the exact name of the required information"
read -p "Enter the name of the required information(default nothing): " other_wip_info
printf "$format" Count "IP Address" Status "WhoIs Organization/Descr" "$other_wip_info"
printf "%s\n" "==========================================================================================================="
### Get netstat and look for lines from it where there is data entered in name_pid and display connection count ip status
$sudo_user $xns 2>/dev/null | mawk '/'$name_pid'/ {ip=$'$xip'; sub(/:[^:]+/,"",ip); state=$'$xstate'; if($'$xip' ~ /^[0-9]/ && $'$xstate' !~ /^[0-9]/ && $'$xpid' ~ '$name_pid' ) print ip, state}' | sort | uniq -c | sort | while read count ip status
do
  if [[ $x -le $lines_number ]]
    then
        let x++
    else
        exit 3
  fi
  if [[ ! -z $other_wip_info ]]
    then
        wip2=$(whois $ip | awk -F':' '/^'$other_wip_info'/ {print $2; exit}' | sed 's,^ *,,; s, *$,,')
    else
        wip2="xxxxx"
  fi
        wip=$(whois $ip | awk -F':' '/^Organization|descr/ {print $2; exit}' | sed 's,^ *,,; s, *$,,')
  if [[ ! -z $wip ]]
    then
        if  [[ ! -z $wip2 ]]
          then
              printf "$format" $count $ip $status "$wip" "$wip2"
          else
              printf "$format" $count $ip $status "$wip" "$other_wip_info not found"
        fi
    else
        if  [[ ! -z $wip2 ]]
          then
              printf "$format" $count $ip $status "$wip2"
          else
              printf "$format" $count $ip $status "WhoIs Organization UNKNOWN" "$other_wip_info not found"
        fi
  fi
done
