# Project with long unknown code

***
```
sudo netstat -tunapl | awk '/firefox/ {print $5}' | cut -d: -f1 | sort | uniq -c | sort | tail -n5 | grep -oP '(\d+\.){3}\d+' | while read IP ; do whois $IP | awk -F':' '/^Organization/ {print $2}' ; done
```
***

## Task

***

* - [x] Convert code to script
* - [x] The script must accept PID or Program name as argument
* - [x] It should be possible to adjust the amount of output
* - [x] It should be possible to see the status of the connection
* - [x] There should be clear error messages
* - [x] The script should not depend on startup privileges or generate warnings
* - [x] ***The script displays the number of connections***
* - [x] ***The script allows you to get other data from whois***
* - [x] ***The script can work with ss***

## What the script does

***

* Gives a choice which command do you want to use, 'netstat' or 'ss'
* Gives a choice to escalate privileges
* Ask for the name or PID of the program
* Request number of output results
* Request other WhoIs information
* The script counts the number of connections
* The script checks the entered data and notifies you if any data is incorrect or if there is some other error in processing the data

## Example:

***

```
Which command do you want to use, 'netstat' or 'ss'(default 'netstat')?
'1' for use 'netstat'
'2' for use 'ss'
Enter your choise number 1/2 (default 1 for 'netstat'): 2
The command will be used 'ss'
Run script from sudo user?
You need root privileges to see all information
Which command do you want to use, 'netstat' or 'ss'(default 'netstat')?
'1' for use 'netstat'
'2' for use 'ss'
Enter your choise number 1/2 (default 1 for 'netstat'): 2
The command will be used 'ss'
Run script from sudo user?
You need root privileges to see all information
Enter 'y' or 'n' (default n(No)): y
[sudo] password for username:
Script run with root privileges
Enter PID/Program name: firefox
Enter number of output results: 12
Want to see other WhoIs information?
You need to enter the exact name of the required information
Enter the name of the required information(default nothing): Address
Count   IP Address        Status          WhoIs Organization/Descr                           Address
===========================================================================================================
1       159.69.59.100     ESTAB           RIPE Network Coordination Centre (RIPE)            P.O. Box 10096
1       172.67.221.19     ESTAB           Cloudflare, Inc. (CLOUD14)                         101 Townsend Street
1       178.154.131.216   ESTAB           Yandex enterprise network                          Address not found
1       213.180.193.90    ESTAB           Yandex enterprise network                          Address not found
1       52.42.50.159      ESTAB           Amazon Technologies Inc. (AT-88-Z)                 410 Terry Ave N.
1       5.255.255.77      ESTAB           Yandex enterprise network                          Address not found
1       52.85.243.121     ESTAB           Amazon Technologies Inc. (AT-88-Z)                 410 Terry Ave N.
1       79.137.219.163    ESTAB           Hosting and Colocation Services                    Address not found
1       87.250.250.119    ESTAB           Yandex enterprise network                          Address not found
1       95.216.2.91       ESTAB           Hetzner Online GmbH                                Address not found
2       44.238.190.78     ESTAB           Amazon.com, Inc. (AMAZO-4)                         Amazon Web Services
3       93.158.134.119    ESTAB           Yandex enterprise network                          Address not found

```

## Known issues 
#### (We will fix it in the next releases)

***

* PID/Program name should be 0-9, A-z
* Perhaps needs to count the number of connections by Organization name, not by IP
* Cannot choose to show connections by status
