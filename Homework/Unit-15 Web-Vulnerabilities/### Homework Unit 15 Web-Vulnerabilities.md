### Homework Unit 15 Web-Vulnerabilities and Hardening

#### Web Application 1: You Wish is My Command Injection

![DVWA](1.1DVWA)

##### Steps to set up:

Command to clear out all the docker containers that were not running

`docker rm $(docker ps --filterstatus=exited -q)`

Close out of apache2 and nginx so there woult be any conflicts with ports. 

`systemctl stop apache2`
`systemctl stop nginx`

Load up the docker file with DVWA and bWAAP

`cd ~/Documents/web-vulns && docker-compose up`

In a Browser navigate to http://192.168.13.25/vulnerabilities/exec/

##### Walkthrough:

Test Pings
![test pings](1.2TestPings.jpg)
it looks like a standard `ping` request when compared to a command line ping

Testing a Command Injection
![Testing a Command Injection](1.3Test.png)


Task:
`8.8.8.8 && cat ../../../../../etc/passwd` 
`8.8.8.8 && cat ../../../../../etc/hosts` 

----------------------

Proof of Exploit:

![etc/passwd](1.4passwd.png)
![etc/hosts](1.5passwd)


Mitigation Strategy:
Whitelist approved characters for the applications input. IP addresses do not need all letters and symbols.

#### Web Application 2: A Brute Force to Be Reckoned With

![bWAAP](2.1Bwapp)

##### Steps to set up:

With the Docker already running  from the previous step
navigate to http://192.168.13.35/install.php
click install
Click Login
	-Login: bee
	-password: bug
Navigate to "Broken Authentication - Insecure Login Forms"
or http://192.168.13.35/ba_insecure_login_1.php

Activte FoxyProxy and enable Burp
![foxyproxy](2.2foxyproxy)


Load Up Burp Suite
![burp](2.3burpsuite)

Click icon in the Applications menu
alternatively you can use the command `sudo burpsuite` from a terminal
start a new temporary project
click on the `proxy` tab
ensure that `intercept is on` is selected
Reload the bwapp page in the browser
![burp Intercept](2.4BurpIntercept)
Go back into burp to find the HTML waiting to be forwarded
click `forward` in burp suite
It looks like burp is intercepting traffic and should be good to go. 

#### Walkthrough:

Find the intercepted html from the bWAPP request
right click it and `send to Intruder`

![Intruder](2.5sendtointruder)
Intruder Tab
![IntruderTab](2.6IntruderTab)
Select `positions`
![Positions](2.7PayloadPositions)
`clear`
Highlight "bee" and click add
Highlight "bug" and click add

this will add two payloads to test with burp, the login and password fields.
![update payloads](2.8payloads)

#### Task:

With the payloads configured now it is time to test our the lists: 
In Burp click on `Payloads`
There should be two variables that have been set up prior that are the Login and Password fields of the bWAPP application
Add the corresponding lists to each payload set. 

Payload 1 Login:
"listofadmins.txt"
![admins](2.09.listofadmins)

Payload 2 Password:
"breached_passwords.txt"
![passwords](2.10.breachedpasswords)
----------------------

start the attack
![attack running](2.11lists)
Burp suite is now running every password / login combo from the lists that were inputed.

#### Proof of Exploit:
One entry came back with a larger length indicating that something was different with this attempt.

![different response](2.12differentresponse)
![HTML](2.13HTMLResponse)


#### Mitigation Strategy:

Increasing Password complexity would force "tonystark" to get a better password. 
two-factor authentication and limiting the amount of login attempts  for a given period of time would help reduce the risks from a brute force attack such as this. 


#### Web Application 3: Wheres the BeEF?

![BeEF](3.1BeEF)

Steps: Setting up ____
In terminal `sudo beef`
In a browser travel to http://127.0.0.1:3000/ui/authentication
Username `beef`
Password `feeb`

Loadup the sample webpage

![beef connection](3.2beefconnection)
the browser is now hooked
select the browser and navigate to the commands tab

![beef command menu](3.3beef commands)

Now that it is confirmed Beef is operating delete the connection to test DVWA




Walkthrough:
![DVWA XSS](3.4DVWA)
![DVWA XSS character Limit](3.5DVWA Character Limit)

The script is too long for the message box.
Right click the "message" field and select "inspect element"
![Inspect the Element](3.6inspecttheelement)

It appears to have  a "max length" for this field
Adjust the parameter to 100
![element modification](3.7elementmodification)
This will allow the script to fit into the field
![Submission Command](3.8xsscommand)
![BeEF Connection](3.9beefconnection)
Great Success, BeEF has now infected the browser. 




Task:
Social Engineerin >>Pretty Theft in action
![Pretty Theft](3.10PrettyTheft)
Pretty Theft Data Collection:
![Pretty Theft Data](3.11PrettyTheftData)
Social Engineering >> Fake Notification Bar
![Fake Notification Bar](3.12FakeNotificationBar)
Result of a risky click
![Result Fake Notification Bar](3.13FakeNotificationResult)
----------------------
Mitigation Strategy:

Best practice may be simply not allowing HTML to be injected into submission fields. 