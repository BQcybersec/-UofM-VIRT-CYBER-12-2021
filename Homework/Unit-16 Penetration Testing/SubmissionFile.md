## Week 16 Homework Submission File: Penetration Testing 1

#### Step 1: Google Dorking


- Using Google, can you identify who the Chief Executive Officer of Altoro Mutual is:

Yes, the Chief Executive Officer is Karl Fitzgerald

`demo.testfire.net: Altoro Mutual CEO`

![Google Dork](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/01.Google%20Dork.png)


- How can this information be helpful to an attacker:

They can use this information to target the head of the company in a "whaling attack" 


#### Step 2: DNS and Domain Discovery

Enter the IP address for `demo.testfire.net` into Domain Dossier and answer the following questions based on the results:

  1. Where is the company located: 

    - San Antonio, Texas

  2. What is the NetRange IP address:
    
    - 65.61.137.64 - 65.61.137.127

  3. What is the company they use to store their infrastructure:

    -Rackspace Backbone Engineering

  4. What is the IP address of the DNS server:

    -65.61.137.117

#### Step 3: Shodan

- What open ports and running services did Shodan find:

![Open Ports](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/02.open_ports.png)

#### Step 4: Recon-ng

- Install the Recon module `xssed`. 

![Install Recon Module](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/03.InstallReconModule.png)
- Set the source to `demo.testfire.net`. 
![Set Source](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/04.Set%20Source.png)

- Run the module. 
![Run](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/05.Run%20The%20Module.png)

Is Altoro Mutual vulnerable to XSS: 

Yes
![Altoro Mutual Vulnerability](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/06.Altoro%20Vulnerability.png)



### Step 5: Zenmap

Your client has asked that you help identify any vulnerabilities with their file-sharing server. Using the Metasploitable machine to act as your client's server, complete the following:

- Command for Zenmap to run a service scan against the Metasploitable machine: 

`nmap -sV 192.168.0.10`
 
- Bonus command to output results into a new text file named `zenmapscan.txt`:

`nmap -sV -oN zenmapscan.txt 192.168.0.10`

- Zenmap vulnerability script command: 

`nmap -T4 -A -v --script ftp-vsftpd-backdoor 192.168.0.10

- Once you have identified this vulnerability, answer the following questions for your client:
  1. What is the vulnerability:
  
  - CVE-2011-2523 contains a backdoor which opens a shell on port 6200

  2. Why is it dangerous:

    - If someone used the backdoor they would have a shell in the server where they could execute commands and access your data. 

    ![Danger Score](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-16%20Penetration%20Testing/Images/07.DangerScore.png)

  3. What mitigation strategies can you recommendations for the client to protect their server:

  -I would recommend to the client that they should update the OS and Vsftpd version

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  

