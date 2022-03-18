## Unit 11 Submission File: Network Security Homework 

### Part 1: Review Questions 

#### Security Control Types

The concept of defense in depth can be broken down into three different security control types. Identify the security control type of each set  of defense tactics.

1. Walls, bollards, fences, guard dogs, cameras, and lighting are what type of security control?

    Answer: Physical Controls

2. Security awareness programs, BYOD policies, and ethical hiring practices are what type of security control?

    Answer:Administrative Controls

3. Encryption, biometric fingerprint readers, firewalls, endpoint security, and intrusion detection systems are what type of security control?

    Answer: Technical Controls

#### Intrusion Detection and Attack indicators

1. What's the difference between an IDS and an IPS?

    Answer:
        IPS: is an active system, and has the ability to prevent known malicious traffic from reaching the protected system
        IDS: is a passive system that alerts an administrator if it detects malicious activity or traffic

2. What's the difference between an Indicator of Attack and an Indicator of Compromise?

   Answer:
    IOA: Inicates that an attack is happening in real time.
    IOC: Indicates a system has been compromised due to previous malicious activity.

#### The Cyber Kill Chain

Name each of the seven stages for the Cyber Kill chain and provide a brief example of each.

1. Stage 1: Reconnaissance: Gathering information about the target, and any potential vulnerabilities in their network or system. 

2. Stage 2: Weaponization: Creating a weapon that is customized based on the information gathered from the Reconnaissance stage.

3. Stage 3: Delivery: This  is the stage where the weapon is transmitted to the target. 

4. Stage 4: Exploitation: The Malware is triggered to exploit the target weakness

5. Stage 5: Installation: The weapon is installed on the targets system

6. Stage 6: Command and Control: the weapon is used to control or manipulate the target remotely by the attacker

7. Stage 7: Actions on Objectives: this where the weapon delivers the goal set out by the attacker. 


#### Snort Rule Analysis

Use the Snort rule to answer the following questions:

Snort Rule #1

```bash
alert tcp $EXTERNAL_NET any -> $HOME_NET 5800:5820 (msg:"ET SCAN Potential VNC Scan 5800-5820"; flags:S,12; threshold: type both, track by_src, count 5, seconds 60; reference:url,doc.emergingthreats.net/2002910; classtype:attempted-recon; sid:2002910; rev:5; metadata:created_at 2010_07_30, updated_at 2010_07_30;)
```

1. Break down the Sort Rule header and explain what is happening.

   Answer: This is a snort rule to document and alert the snort user of any external network attempting to scan ports between 5800 - 5820

2. What stage of the Cyber Kill Chain does this alert violate?

   Answer: Reconnassaince

3. What kind of attack is indicated?

   Answer: The attack they are protecting from is if anybody tries to scan their servers port access.

Snort Rule #2

```bash
alert tcp $EXTERNAL_NET $HTTP_PORTS -> $HOME_NET any (msg:"ET POLICY PE EXE or DLL Windows file download HTTP"; flow:established,to_client; flowbits:isnotset,ET.http.binary; flowbits:isnotset,ET.INFO.WindowsUpdate; file_data; content:"MZ"; within:2; byte_jump:4,58,relative,little; content:"PE|00 00|"; distance:-64; within:4; flowbits:set,ET.http.binary; metadata: former_category POLICY; reference:url,doc.emergingthreats.net/bin/view/Main/2018959; classtype:policy-violation; sid:2018959; rev:4; metadata:created_at 2014_08_19, updated_at 2017_02_01;)
```

1. Break down the Snort Rule header and explain what is happening.

   Answer: This is an alert to notify an administrator if a computer downloads an .exe or DLL file off of the internet. 

2. What layer of the Defense in Depth model does this alert violate?

   Answer: Administrative, Policy violation. 

3. What kind of attack is indicated?

   Answer: Malware, trying to load on the system.

Snort Rule #3

- Your turn! Write a Snort rule that alerts when traffic is detected inbound on port 4444 to the local network on any port. Be sure to include the `msg` in the Rule Option.

    Answer:
```bash    
    alert tcp $External_Net 4444 -> $Home_Net any (msg: "port 4444 activity detected inbound") 
```

### Part 2: "Drop Zone" Lab

#### Log into the Azure `firewalld` machine

Log in using the following credentials:

- Username: `sysadmin`
- Password: `cybersecurity`

#### Uninstall `ufw`

Before getting started, you should verify that you do not have any instances of `ufw` running. This will avoid conflicts with your `firewalld` service. This also ensures that `firewalld` will be your default firewall.

- Run the command that removes any running instance of `ufw`.

    ```bash
    $ <sudo ufw disable>
    ```

#### Enable and start `firewalld`

By default, these service should be running. If not, then run the following commands:

- Run the commands that enable and start `firewalld` upon boots and reboots.

    ```bash
    $ <sudo systemctl enable firewalld>
    $ <sudo systemctl start firewalld>
    ```

  Note: This will ensure that `firewalld` remains active after each reboot.

#### Confirm that the service is running.

- Run the command that checks whether or not the `firewalld` service is up and running.

    ```bash
    $ <sudo systemctl status firewalld>
    ```


#### List all firewall rules currently configured.

Next, lists all currently configured firewall rules. This will give you a good idea of what's currently configured and save you time in the long run by not doing double work.

- Run the command that lists all currently configured firewall rules:

    ```bash
    $ <sudo firewall-cmd --list-all-zones>
    ```

- Take note of what Zones and settings are configured. You many need to remove unneeded services and settings.

#### List all supported service types that can be enabled.

- Run the command that lists all currently supported services to see if the service you need is available

    ```bash
    $ <sudo firewall-cmd --get-services>
    ```

- We can see that the `Home` and `Drop` Zones are created by default.


#### Zone Views

- Run the command that lists all currently configured zones.

    ```bash
    $ <sudo firewall-cmd --list-all-zones>
    ```

- We can see that the `Public` and `Drop` Zones are created by default. Therefore, we will need to create Zones for `Web`, `Sales`, and `Mail`.

#### Create Zones for `Web`, `Sales` and `Mail`.

- Run the commands that creates Web, Sales and Mail zones.

    ```bash
    $ <sudo firewall-cmd --permanent --new-zone=Web>
    $ <sudo firewall-cmd --permanent --new-zone=Sales>
    $ <sudo firewall-cmd --permanent --new-zone=Mail>
    ```

#### Set the zones to their designated interfaces:

- Run the commands that sets your `eth` interfaces to your zones.

    ```bash
    $ <sudo firewall-cmd --permanent --zone=public --change-interface=ETH0>
    $ <sudo firewall-cmd --permanent --zone=Web --change-interface=ETH1>
    $ <sudo firewall-cmd --permanent --zone=Sales --change-interface=ETH2>
    $ <sudo firewall-cmd --permanent --zone=Mail --change-interface=ETH3>
    ```

#### Add services to the active zones:

- Run the commands that add services to the **public** zone, the **web** zone, the **sales** zone, and the **mail** zone.

- Public:

    ```bash
    $ <sudo firewall-cmd --permanent --zone=public --add-service=http>
    $ <sudo firewall-cmd --permanent --zone=public --add-service=https>
    $ <sudo firewall-cmd --permanent --zone=public --add-service=pop3>
    $ <sudo firewall-cmd --permanent --zone=public --add-service=smtp>
    ```

- Web:

    ```bash
    $ <sudo firewall-cmd --permanent --zone=Web --add-service=http>
    ```

- Sales

    ```bash
    $ <sudo firewall-cmd --permanent --zone=Sales --add-service=https>
    ```

- Mail

    ```bash
    $ <sudo firewall-cmd --permanent --zone=Mail --add-service=smtp>
    $ <sudo firewall-cmd --permanent --zone=Mail --add-service=pop3>
    ```

- What is the status of `http`, `https`, `smtp` and `pop3`?

#### Add your adversaries to the Drop Zone.

- Run the command that will add all current and any future blacklisted IPs to the Drop Zone.

     ```bash
    $ <sudo firewall-cmd --permanent --zone=drop --add-source=10.208.56.23>
    $ <sudo firewall-cmd --permanent --zone=drop --add-source=135.95.103.76>
    $ <sudo firewall-cmd --permanent --zone=drop --add-source=176.34.169.118>
    ```

#### Make rules permanent then reload them:

It's good practice to ensure that your `firewalld` installation remains nailed up and retains its services across reboots. This ensure that the network remains secured after unplanned outages such as power failures.

- Run the command that reloads the `firewalld` configurations and writes it to memory

    ```bash
    $ <sudo firewall-cmd --runtime-to-permanent>
    ```

#### View active Zones

Now, we'll want to provide truncated listings of all currently **active** zones. This a good time to verify your zone settings.

- Run the command that displays all zone services.

    ```bash
    $ <sudo firewall-cmd --list-all-zones>
    ```


#### Block an IP address

- Use a rich-rule that blocks the IP address `138.138.0.3`.

    ```bash
    $ <sudo firewall-cmd --permanent --zone=public --add-rich-rule="rule family='ipv4' source address='138.138.0.3' reject">
    ```

#### Block Ping/ICMP Requests

Harden your network against `ping` scans by blocking `icmp ehco` replies.

- Run the command that blocks `pings` and `icmp` requests in your `public` zone.

    ```bash
    $ <sudo firewall-cmd --permanent --zone=public --add-icmp-block=echo-reply ->
    ```

#### Rule Check

Now that you've set up your brand new `firewalld` installation, it's time to verify that all of the settings have taken effect.

- Run the command that lists all  of the rule settings. Do one command at a time for each zone.

    ```bash
    $ <sudo firewall-cmd --zone=public --list-all>
    $ <sudo firewall-cmd --zone=drop --list-all>
    $ <sudo firewall-cmd --zone=Web --list-all>
    $ <sudo firewall-cmd --zone=Sales --list-all>
    $ <sudo firewall-cmd --zone=Mail --list-all>
    ```

- Are all of our rules in place? If not, then go back and make the necessary modifications before checking again.


Congratulations! You have successfully configured and deployed a fully comprehensive `firewalld` installation.

---

### Part 3: IDS, IPS, DiD and Firewalls

Now, we will work on another lab. Before you start, complete the following review questions.

#### IDS vs. IPS Systems

1. Name and define two ways an IDS connects to a network.

   Answer 1:Network TAP (Test Access Port)
                -Taps into the network between the router and the switch 

   Answer 2:SPAN (Switched Port Analyzer) (port mirroring)
                -Receives a copy of all network data to be captured and analyzed. 
                -mirrors the network at the switch

2. Describe how an IPS connects to a network.

   Answer: Inline with the network traffic after the firewall

3. What type of IDS compares patterns of traffic to predefined signatures and is unable to detect Zero-Day attacks?

   Answer: Signature-based IDS

4. Which type of IDS is beneficial for detecting all suspicious traffic that deviates from the well-known baseline and is excellent at detecting when an attacker probes or sweeps a network?

   Answer: Anomaly-based IDS

#### Defense in Depth

1. For each of the following scenarios, provide the layer of Defense in Depth that applies:

    1.  A criminal hacker tailgates an employee through an exterior door into a secured facility, explaining that they forgot their badge at home.

        Answer: Perimeter

    2. A zero-day goes undetected by antivirus software.

        Answer: Application

    3. A criminal successfully gains access to HR’s database.

        Answer: Data

    4. A criminal hacker exploits a vulnerability within an operating system.

        Answer: Host

    5. A hacktivist organization successfully performs a DDoS attack, taking down a government website.

        Answer: Network

    6. Data is classified at the wrong classification level.

        Answer: Data

    7. A state sponsored hacker group successfully firewalked an organization to produce a list of active services on an email server.

        Answer:Network, Data

2. Name one method of protecting data-at-rest from being readable on hard drive.

    Answer: Passwords

3. Name one method to protect data-in-transit.

    Answer: Encryption

4. What technology could provide law enforcement with the ability to track and recover a stolen laptop.

   Answer:GPS, MAC Address

5. How could you prevent an attacker from booting a stolen laptop using an external hard drive?

    Answer:Disable usb boot in the bios and password protect the bios config


#### Firewall Architectures and Methodologies

1. Which type of firewall verifies the three-way TCP handshake? TCP handshake checks are designed to ensure that session packets are from legitimate sources.

  Answer: Curcuit-level Firewall

2. Which type of firewall considers the connection as a whole? Meaning, instead of looking at only individual packets, these firewalls look at whole streams of packets at one time.

  Answer: Application Firewall, Dynamic Filtering, Stateful Firewall 

3. Which type of firewall intercepts all traffic prior to being forwarded to its final destination. In a sense, these firewalls act on behalf of the recipient by ensuring the traffic is safe prior to forwarding it?

  Answer:Statefull packet-filtering


4. Which type of firewall examines data within a packet as it progresses through a network interface by examining source and destination IP address, port number, and packet type- all without opening the packet to inspect its contents?

  Answer:Stateless packet-filtering


5. Which type of firewall filters based solely on source and destination MAC address?

  Answer: MAC Firewall



### Bonus Lab: "Green Eggs & SPAM"
In this activity, you will target spam, uncover its whereabouts, and attempt to discover the intent of the attacker.
 
- You will assume the role of a Jr. Security administrator working for the Department of Technology for the State of California.
 
- As a junior administrator, your primary role is to perform the initial triage of alert data: the initial investigation and analysis followed by an escalation of high priority alerts to senior incident handlers for further review.
 
- You will work as part of a Computer and Incident Response Team (CIRT), responsible for compiling **Threat Intelligence** as part of your incident report.

#### Threat Intelligence Card

**Note**: Log into the Security Onion VM and use the following **Indicator of Attack** to complete this portion of the homework. 

Locate the following Indicator of Attack in Sguil based off of the following:

- **Source IP/Port**: `188.124.9.56:80`
- **Destination Address/Port**: `192.168.3.35:1035`
- **Event Message**: `ET TROJAN JS/Nemucod.M.gen downloading EXE payload`

Answer the following:

1. What was the indicator of an attack?
   - Hint: What do the details of the reveal? 

    Answer:  A snort rule triggered an alert about downloading an EXE payload. I determined the system compromised when I saw that the source IP also had a singular instance as the destination IP (possibly as a way of phoneing home) There was a questionable file associated with the alert and when I loaded the file into a virus scanner it was known by several vendors and they said it was a viariant of the "Zbot"


2. What was the adversarial motivation (purpose of attack)?

    Answer: A trojan virus was installed, most likely to steal financial information or an attempt at identity theft. 

3. Describe observations and indicators that may be related to the perpetrators of the intrusion. Categorize your insights according to the appropriate stage of the cyber kill chain, as structured in the following table.

| TTP | Example | Findings |
| --- | --- | --- | 
| **Reconnaissance** |  How did they attacker locate the victim? | It was most likely a spam email with a malicious link
| **Weaponization** |  What was it that was downloaded?| a tmp file disguised as an image
| **Delivery** |    How was it downloaded?| The file communicated back to a remote server and downloaded the trojan
| **Exploitation** |  What does the exploit do?| It loads into the the system32 folder and places two .dll files that it uses to store information from the infected system.  
| **Installation** | How is the exploit installed?|If it can proceed it will then amend registry keys to enable it's execution at startup and inject itself into other processes 
| **Command & Control (C2)** | How does the attacker gain control of the remote machine?|the Tojan will proceed to harvest data from the host machine, depending on the particular Zbot it could be capable of a range of things, such as redirecting to sites it defines, keylogging the infected computer, presenting fake web pages (controlled by the hacker) in attempts to gather information any information it can. Historically this type of bot has been written to gather banking information. 
| **Actions on Objectives** | What does the software that the attacker sent do to complete it's tasks?|The bot will proceed to send the collected data back to a server defined by the trojans author. 


    Answer: 


4. What are your recommended mitigation strategies?


    Answer: Due to this particular trojan being able to install iteself into other proccesses in the system I would recommend a fresh install of the infected computer from a system image before this attack occured. 
        I also noticed that the infected computer also attempted to re-install the trojan on 4 other systems after it had been infected. I would recommend a clean system install for those systems as well. The user of the attacked system should also change his passwords to all acounts attached to that computer, and if banking information was gathered on that system have them contact the bank about having their account potentially compromised. 




5. List your third-party references.

    Answer: [zbot article](f-secure.com/v-descs/trojan-spy_w32_zbot.shtml)
            [virustotal](virustotal.com)

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
