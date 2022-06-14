# Red Team: Summary of Operations

## Table of Contents
- Exposed Services
- Critical Vulnerabilities
- Exploitation

### Exposed Services

nmap ping sweep
`nmap -sP 192.168.1.1-255`
![red.01.pingsweep](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.01.pingsweep.png)

Nmap scan results for each machine reveal the below services and OS details:
Nmap Service Scans of the network

hypervisor
`nmap -sV 192.168.1.1`

![red.o2.hypemachine](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.02.nmap.hyperviser.png)

ELK
`nmap -sV 192.168.1.100`

![elk](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.03.nmap.elk.png)

Capstone
`nmap -sV 192.168.1.105`

![capstone](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.04.nmap.capstone.png)


Target 1
`nmap -sV 192.168.1.110`

![Target1](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.05.nmap.target1.png)

This scan identifies the services below as potential points of entry:
- Target 1
  Ports 80 and 22 are open 
  


The following vulnerabilities were identified on each target:

- Target 1
  - List of
  - Critical
  - Vulnerabilities

Vulnerable and outdated software:
    Old Versions of Apache, Wordpress, MySQL

Security Misconfiguration:
    Weak password on an exposed server

Broken Access Control:
    Wordpress read/write permissions 
    Non-Root Python Access for privilege escalation



### Exploitation


The Red Team was able to penetrate `Target 1` and retrieve the following confidential data:
- Target 1
  
- `flag1.txt` `flag2.txt`

![Flags1 and 2](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.06.flags1-2.png)
    
    - **Exploit Used**

   
      - Nmap Ping Sweep of the entire network
          `Nmap -sP 192.168.1.1-255`

      - Nmap Service Scan of Target 1
          `Nmap -sV 192.168.1.110`

      - Wordpress Enumeration with wpscan
          `wpscan --url http://192.168.1.110/wordpress -eu`

      -I Was able to guess a password of one of the users and ssh
            `ssh michael@192.168.1.110`

- `flag3.txt`

![flag3](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.13.flag3.png)

- **Exploit Used**
    - Wordpress was not properly configured and the file wp-config.php could be viewed by any user. This allowed me to dump the data containing Root Login info for the MySQL database which contained hashed passwords for the users of the system.
        
        `cat wp-config.php`

![WordPress Cat](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.07.wordpresscat.png)

        `root:R@v3nSecurity`
        `mysql -u root -p`
![MySQL Login](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.08.MySQL-Login.png)
       
        `select * from wp_users`

![mySQL hash extraction](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.09.mysqlhashextraction.png)

    - Using John the Ripper to crack the hashes
![John the Ripper](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.10.johntheripper.png)

- `flag4.txt`

![flag4](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.14.flag4.png)

  -SSH into the system as steven. and check the sudo privileges. he can run python scripts so I ran a python script that escalates the user to the root level

![Python Script](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/red.11.pythonscript.png)