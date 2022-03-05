## Homework Unit 09
Ben Qualey

## Mission 1
[nslookup -type=mx starwars.com](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/01.Mission1(nslookup).png)

The mail is being directed to alternate locations. The newly set up servers are not recognized within the dns for starwars.com


starwars.com	mail exchanger	=	1	asltx.1.google.com
starwars.com	mail exchanger	=	5	asltx.2.google.com


## Mission 2

[SPF Lookup](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/02.Mission2(spflookup).png)

The spf would fail in this instance due to the server change. Looking at the primary mail exchanger for the site and then looking up that ip address shows that it doesn’t line up with the IP address that theforce.net is sending it's communications from. This would trigger the spf to fail thus moving the communication into the spam folder.

[IP address of the new server](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/03.Mission2(addressofnewserver).png)

How it should look to avoid the spam problem.

nslookup smpt.secureserver.net

non-authoritative answer:

name:	smtp.secureserver.net

address:	45.23.176.21

or

theforce.net	mail exchange	=	0	lightspeed.rcsntx.sbcglobal.net


## Mission 3

[CNAME of www.theforce.net](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/04.Mission3(cname).png)

It appears they have taken the derver down for [resistance.theforce.net](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/05.Mission3(serverdown).png)

resistance.theforce.net	canonical name	=	theforce.net

The nslookup for resistance.theforce.net should contain an IP address instead of an error code. 


## Mission 4

[DNS for princessleia.site](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/06.Mission4(princessleiaDNS).png)

To prevent the issue from happening again you would want to create a secondary DNS with a traffic redirection to ns2.galaxybackup.com that becomes operational in the case of the princessleia.site server goes down.

## Mission 5

OSPF: Batau-d1-c2-e1-f1-j1-i1-l6-q4-t2-v2-2jedha

## Mission 6

[Steps to examine the pcap file](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/07.Mission%206(pcap).png)

1. I used aircrack with the "rockyou" word list to crack the wpa-password
2. I inputed the password and wifi ssid into wireshark
3. I did an arp search to find the MAC address and IP address



## Mission 7


[the grand finale](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/08.Mission7(thegrandfinale).png)



