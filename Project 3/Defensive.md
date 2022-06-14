# Blue Team: Summary of Operations

## Table of Contents
- Network Topology
- Description of Targets
- Monitoring the Targets
- Patterns of Traffic & Behavior
- Suggestions for Going Further

### Network Topology

![network](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.jpg)

The following machines were identified on the network:
- Target 1
  - **Operating System**: Linux
  - **Purpose**: Hosts a Wordpress site for an organization, the target of the attack. 
  - **IP Address**: 192.168.1.110

- Elk
  - **Operating System**: Linux
  - **Purpose**: Elasticsearch server 
  - **IP Address**: 192.168.1.100

- Capstone
  - **Operating System**: Linux
  - **Purpose**: A system to test alerts in Kibana 
  - **IP Address**: 192.168.1.105


- Kali
  - **Operating System**: Linux
  - **Purpose**: Pentesting machine on the network 
  - **IP Address**: 192.168.1.90


### Description of Targets
_TODO: Answer the questions below._

The target of this attack was: `Target 1 192.168.1.110` 

Target 1 is an Apache web server and has SSH enabled, so ports 80 and 22 are possible ports of entry for attackers. As such, the following alerts have been implemented:


#### Excessive HTTP Errors

Excessive HTTP Errors is implemented as follows:
  - **Metric**: If a server is firing off multiple 400 error codes
  - **Threshold**: 5 error codes in a one minute period of time
  - **Vulnerability Mitigated**: An excessive amount of failure codes would indicate that an attack is potentially occuring. 
 

  ![excessive HTTP errors](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/blue.01.excessivehttperros.png)
  ![excessive HTTP erros2](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/blue.05.httperrorsintime.png)

#### HTTP request size monitor
HTTP request size monitor is implemented as follows:
  - **Metric**: The size of HTTP requests
  - **Threshold**: when the size of HTTP requests exceeds 3500 bytes in one minute
  - **Vulnerability Mitigated**: Unusual HTTP requests from the server
  - **Reliability**: This alert created a lot of false positives due to the size being to small. 

  ![request size monitor](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/blue.02.requestsizemonitor.png)

#### CPU usage monitor
CPU usage monitor is implemented as follows:
  - **Metric**: If there is a sudden spike in CPU usage
  - **Threshold**: 50% of the cpu is being used
  - **Vulnerability Mitigated**: This will notify the SOC if suspicious activity is occuring on a server that is utilizing above average resources. 
  - **Reliability**: I thought this was a good indicator of an attack, if the attack was using brute force or had a high demand of the server. It would not catch an attacker if they were being stealthy. 

  ![Cpu Usage](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/blue.03.cpuusage.png)



### Suggestions for Going Further 

- Vulnerability 1 Vulnerable and outdated software
  - **Patch**:Create an Ansible script that will update the software to the latest versions
  - **Why It Works**:  This is a good frontline defense because there will be less known vulnerabilities in software that is up-to-date.
- Vulnerability 2 Security Misconfiguration
  - **Patch**: If it is not realistic to change the way SSH is done into the system, Users must have much stronger passwords due to the server being exposed to the web. 
  - **Why It Works**: It may not be perfect but having strong password requirements will make sure that it is much tougher to gain entry into the system without being noticed. 
- Vulnerability 3 Broken Access Control 
  - **Patch**: This would be updating the read/ write privileges of the wp-config.php file.
  `chmod 600 /var/www/html/wordpress/wp-config.php`

  - **Why It Works**: This will work because it protect the data from people who do not need access to the data. 
