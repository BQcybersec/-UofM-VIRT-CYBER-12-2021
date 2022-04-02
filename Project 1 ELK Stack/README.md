## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Elk Stack Diagram](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Network%20Diagrams/RedElkDiagram.jpg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible scripts may be used to install only certain pieces of it, such as Filebeat.

["Ansible Scripts"](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/tree/main/Project%201%20ELK%20Stack/Ansible%20Scripts)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting unauthorized access to the network.

- What aspect of security do load balancers protect? 

  - The Load Balancer aids in the availability aspect of this setup in case one or more of the machines go down for any reason. If a machine goes down the load balancer can divert the traffic to a different machine that is still operational, maintaining application availability. It also keeps the web machines from having an individual public IP address, since they all share the Load Balancers IP it reduces the potential attack surface. 

- What is the advantage of a jump box?

  - In this network the Jump box keeps the necessary setup files in a seperate secured location and can reliably re-provision a system in a fast and efficient way. It adds a layer to the security by making it so that you can only work on the web machines from a secured private location that you specify.  

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the network and system performence.

- What does Filebeat watch for?
  
  - Log Files

- What does Metricbeat record?
  
  - System Metrics

The configuration details of each machine may be found below.

| Name     | Function        | Private IP | Public IP     | Operating System | Container |
|----------|-----------------|------------|---------------|------------------|-----------|
| Jump-Box | Control Node    | 10.0.0.4   | 20.7.196.22   |       Linux      | Ansible   |
| Web-1    | Web Application | 10.0.0.5   | 20.92.210.73  |       Linux      | DVWA      |
| Web-2    | Web Application | 10.0.0.6   | 20.92.210.73  |       Linux      | DVWA      |
| Web-3    | Web Application | 10.0.0.7   | 20.92.210.73  |       Linux      | DVWA      |
| ELK      | Monitoring      | 10.1.04    | 13.66.156.191 |       Linux      | ELK Stack |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump-Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:

- My workstations public IP Is the only whitelisted IP with access permission to the Jump-Box. 

- Machines within the network can only be accessed by the Jump-Box.

- Which machine did you allow to access your ELK VM? What was its IP address?

- Access to the ELK virtual machine is done through the Jump box.

A summary of the access policies in place can be found in the table below.

|     Name        |     Publicly   Accessible    |     Allowed IP   Addresses     |
|-----------------|------------------------------|--------------------------------|
|     Jump Box    |              Yes             |           Workstation IP       |
|     Web-1       |              Yes             |     10.0.0.4   Workstation IP  |
|     Web-2       |              Yes             |     10.0.0.4   Workstation IP  |
|     Web-3       |              Yes             |     10.0.0.4   Workstation IP  |
|     ELK         |              Yes             |     10.0.0.4   Workstation IP  |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
 The main advantages of using Ansible to configure a system are it's speed and simplicity. Writing a playbook for Ansible is not too complicated; the language is human readable and powerful. The speed aspect comes once the script is completed because it can be deployed with a single command and you will have a system that is configured to your needs.

The playbook implements the following tasks:

  - Install docker.io
  - Install Python
  - Download and Launch the ELK container


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.
![docker ps](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/01.sudo_docker_ps_ss.png)

### Target Machines & Beats

This ELK server is configured to monitor the following machines:

  - Web-1 10.0.0.5
  - Web-2 10.0.0.6
  - Web-3 10.0.0.7

We have installed the following Beats on these machines:

- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
  
  Filebeat Collects: Syslog files, Sudo commands, SSH Logins, and New Users and Groups.
    This data can give a very good overview if the system has been compromised, attacked or is operating as intended. When looking at this data I would expect to see data from the Jump-Box provisioning the containers and a handful of operations that were used to test the system. Anything unexplained would show the possibility of being compromised. 
### Filebeat syslog overview
![syslog](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/02.syslog_filebeat.png)
### Filebeat sudo commands data
![sudo commands](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/02.Sudo_Commands_Filebeat.png)
### Filebeat SSH login attempt data
![SSH](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/02.SSH_Logins_Filebeat.png)
### Filebeat New Users and Groups data
![New Users and Groups](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/02.new_users_groups_filebeat.png)

  
  

  Metricbeat collects: CPU usage, Load, Memory Usage and Network traffic for all three webmachines. When looking at the data I would expect a corelation with traffic to the individual machine. If one machine is performing a task I would expect to see the CPU usage increase. If I connect to the machine via Jump box or the DVWA application I expect to see a bump in network traffic. This is useful data to get a quick system overview without having to log into the machine itself to see how the hardware is behaving.  

### Metricbeat Overview  
![metricbeat overview](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/03.Metricbeat_overview.png)
### Metricbeat Inventory monitored
![Inventory Monitored](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/03.Inventory_Monitored_metricbeat.png)
### Metricbeat Individual systems monitored
![Individual System Overview](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Images/03.Individual_System_Overview_Metricbeat.png)

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
  - Copy the playbook file to /etc/ansible
  - Update the ansible_config file to include the username you created when you set up the machine. 
  - Update the Host File to include the machines you wish to run the playbook on
  - Run the playbook, and SSH to the machine it was installed on to check that the installation worked as expected.
  - `sudo docker ps` Will give a brief summary of the containers that are installed.


- Which file is the playbook? Where do you copy it?
  - [install_elk.yml](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%201%20ELK%20Stack/Ansible%20Scripts/install_elk.yml) is the playbook itself and I stored it within the Ansible folder on the Linux machine /etc/ansible

Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
  - hosts
  - You place servers into different categories, the categories are referenced within the playbooks themselves. For this install I used two categories "webservers" and "ELK". In each of the categories I pointed the host file to the desired machines private IP address and had diffenrent playbooks for each type of server. 

Which URL do you navigate to in order to check that the ELK server is running?

http://13.66.156.191:5601/app/kibana


