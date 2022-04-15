### Homework Unit 15 Web-Vulnerabilities and Hardening

#### Web Application 1: You Wish is My Command Injection

![DVWA]([1.1DVWA](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/1.1%20DVWA.png))

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
![test pings](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/1.2%20TestPings.png)
it looks like a standard `ping` request when compared to a command line ping

Testing a Command Injection
![Testing a Command Injection](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/1.3%20CommandInjectionTest.png)


Task:
`8.8.8.8 && cat ../../../../../etc/passwd` 
`8.8.8.8 && cat ../../../../../etc/hosts` 

----------------------

Proof of Exploit:

![etc/passwd](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/1.4passwd.png)
![etc/hosts](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/1.5Hosts.png)


Mitigation Strategy:
Whitelist approved characters for the applications input. IP addresses do not need all letters and symbols.

#### Web Application 2: A Brute Force to Be Reckoned With

![bWAAP](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.01%20bWAPP.png)

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
![foxyproxy](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.02foxyproxy.png)


Load Up Burp Suite
![burp](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.03Burpsuite.png)

Click icon in the Applications menu
alternatively you can use the command `sudo burpsuite` from a terminal
start a new temporary project
click on the `proxy` tab
ensure that `intercept is on` is selected
Reload the bwapp page in the browser
![burp Intercept](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.04BurpIntercept.png)
Go back into burp to find the HTML waiting to be forwarded
click `forward` in burp suite
It looks like burp is intercepting traffic and should be good to go. 

#### Walkthrough:

Find the intercepted html from the bWAPP request
right click it and `send to Intruder`

![Intruder](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.05sendtointruder.png)
Intruder Tab
![IntruderTab](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.06intrudertab.png)
Select `positions`
![Positions](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.07PayloadPositions.png)
`clear`
Highlight "bee" and click add
Highlight "bug" and click add

this will add two payloads to test with burp, the login and password fields.
![update payloads](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.08updatedpayloads.png)

#### Task:

With the payloads configured now it is time to test our the lists: 
In Burp click on `Payloads`
There should be two variables that have been set up prior that are the Login and Password fields of the bWAPP application
Add the corresponding lists to each payload set. 

Payload 1 Login:
"listofadmins.txt"
![admins](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.09.listofadminspayload.png)

Payload 2 Password:
"breached_passwords.txt"
![passwords](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.10.breachedpasswords.png)
----------------------

start the attack
![attack running](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.11running%20the%20lists.png)
Burp suite is now running every password / login combo from the lists that were inputed.

#### Proof of Exploit:
One entry came back with a larger length indicating that something was different with this attempt.

![different response](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.12differentresponse.png)
![HTML](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/2.13HtmlResponse.png)


#### Mitigation Strategy:

Increasing Password complexity would force "tonystark" to get a better password. 
two-factor authentication and limiting the amount of login attempts  for a given period of time would help reduce the risks from a brute force attack such as this. 


#### Web Application 3: Wheres the BeEF?

![BeEF](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.1%20BeEF.png)

Steps: Setting up ____
In terminal `sudo beef`
In a browser travel to http://127.0.0.1:3000/ui/authentication
Username `beef`
Password `feeb`

Loadup the sample webpage

![beef connection](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.2beefconnection.png)
the browser is now hooked
select the browser and navigate to the commands tab

![beef command menu](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.3beefcommands.png)

Now that it is confirmed Beef is operating delete the connection to test DVWA




Walkthrough:
![DVWA XSS](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.4dvwaXSS%20screen.png)
![DVWA XSS character Limit](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.5DVWAcharacterlimit.png)

The script is too long for the message box.
Right click the "message" field and select "inspect element"
![Inspect the Element](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.6inspect%20the%20element.png)

It appears to have  a "max length" for this field
Adjust the parameter to 100
![element modification](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.7elementmodification.png)
This will allow the script to fit into the field
![Submission Command](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.8XSScommand.png)
![BeEF Connection](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.9BeEFConnection.png)
Great Success, BeEF has now infected the browser. 




Task:
Social Engineerin >>Pretty Theft in action
![Pretty Theft](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.10PrettyTheft.png)
Pretty Theft Data Collection:
![Pretty Theft Data](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.11PrettyTheftData.png)
Social Engineering >> Fake Notification Bar
![Fake Notification Bar](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.12FakeNotification.png)
Result of a risky click
![Result Fake Notification Bar](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-15%20Web-Vulnerabilities/Images/3.13NotificationBarResult.png)
----------------------
Mitigation Strategy:

Best practice may be simply not allowing HTML to be injected into submission fields. 