Homework Unit 8
BenQualey

### **Phase1**: "I'd like to Teach the World to `Ping`"

-Steps:
    -Determine The IP's for the Hollywood Office
        -Servers 16-20 were appropriate for this assignment due to the fact they had "Hollywood" set as their location within the list provided.
        -I took the appropriate servers and ran their corresponding IPs through a CIDR to Ip4v tool https://www.ipaddressguide.com/cidr

        -fping
            -Attached files contains an image of the table I compiled whilst working on this problem and a document of the actual table. 
            1.  `fping -s -g 15.199.95.80 15.199.95.95`
            2.  `fping -s -g 15.199.94.80 15.199.94.95`
            3.  `fping -s -g 11.199.158.80 11.199.158.95`
            4.  `fping -s 167.172.144.11`
            5.  `fping -s -g 11.199.141.80 11.199.141.95`
        
        -Alive IPs
            -167.172.144.11 is alive
            -Every other IP address is unreachable

    -Vulnerabilities:
        Without knowing much else I would say that the primary vulnerabilty at this stage is having a lone system on the network that stands out amongst the others, potentially positioning itself as a target for potential hackers. 

    -Findings of a Hacker:
        At this phase I do not see any proof of hacking just a possible path a hacker may take. 
    -Mittigation Recomendations:
        They will need to modify this IP address to make it unreachable. 
    -Osi Layer:
        This would be Layer 3 in the OSI model because it is dealing with network IP addresses.

### **Phase2**: "Some `Syn` for Nothin`"

    -Steps:
        -`SYN SCAN`
            `sudo nmap -sS 167.172.144.11`
        -Open Ports
            "22/tcp open ssh"
            The scan reported that port 22 was open.

    -Vulnerabilities:
        -Without strong passwords and a protected system this would be a way to potentially exploit this server.
    -Findings of a Hacker:
        -No indication of a hacker yet. 
    -Mittigation Recomendations:
        -If port 22 is required for operations making sure that anyone who accesses this particular server has adequate passwords.
    -Osi Layer:
        This would be Layer 4 in the OSI model because it involves a potentially vulnerable Port.

### **Phase3**: "I Feel a `DNS` Change Comin' On"

    -Steps
        -Access the Server "SSH'd"
            `ssh jimi@167.172.144.11 -p 22`
        -Look for DNS Modifications
            -`cat /etc/hosts`
                -Attached image "02.DNS Hijacking.png" shows the DNS Hijacking in the Hosts file
            -It appears traffic to "rollingstone.com" is being redirected to 98.137.246.8
            -`nslookup 98.137.246.8` 
                -Attached image "03.nslookup.png" shows the results
            
    -Vulnerabilities
        -With proof in hand I now believe the system has been comprimised and more investigation is needed to determine severity of the hack. 
    -Findings of a Hacker
        -Since the RockCorp office reported the glitch I suspect a hacker has been into the system and modified it as well. 
    -Mittigation Recomendations
        -I would reccomend closing port 22, restoring the system to a previous state and testing the other systems within the company. 
        
    -OSI Layer
        -This would fall under layer 7 of the OSI model seeing as it directly impacts end-user applications. 

### **Phase4**: "Sh`ARP` Dressed Man"

    -Steps
        In the /etc directory there was a filled called "packetcaptureinfo.txt"
        
        `cat /etc/packetcaptureinfo.txt`
            The file contained a link to a .pcap file
        After the risky click of the day I decided to analyze the file with Wireshark. 
            -Two things stood out to me within this packet capture. 
                -"Dupliciate IP Address Detected" warning within one of the ARP packets 
                    -It looks like a hacker sent a spoof ARP message to divert traffic
                    -attached "04.ARP_Duplicate_IP.png"
                -An HTML packet with communications from "Mr. Hacker"
                    -The message stated that Mr Hacker wanted to charge for Username and Password access to the server
                    -Attached "05.HTML_Packet.png"    
    -Vulnerabilities
        The hacker is able to gain write permissions to the home directory they are able to also send packets out from the server itself. 
    -Findings of a Hacker
        The packet was clear evidence that a hacker had infiltrated the system and was looking to make some quick money. 
    -Mittigation Recomendations
        It looks like Rock Corp will have to close port 22
    -Osi Layer
        This would be Layer 2 in the OSI model due to being involved with Address Resolution Protocol (ARP)
        This could also be a Layer 7 in the OSI model because the Packet Capture contained direct communication from a user


"Its the End of the Assessment as We Know It, and I Feel Fine"






     
