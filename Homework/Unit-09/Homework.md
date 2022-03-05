## Homework Unit 09
Ben Qualey

## Mission 1
[nslookup -type=mx starwars.com](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-09/Images/01.Mission1(nslookup).png)

The mail is being directed to alternate locations. The newly set up servers are not recognized within the dns for starwars.com


starwars.com	mail exchanger	=	1	asltx.1.google.com
starwars.com	mail exchanger	=	5	asltx.2.google.com


## Mission 2

[SPF Lookup]

The spf would fail in this instance due to the server change. Looking at the primary mail exchanger for the site and then looking up that ip address shows that it doesn’t line up with the IP address that theforce.net is sending it's communications from. This would trigger the spf to fail thus moving the communication into the spam folder.

[IP address of the new server]

How it should look to avoid the spam problem.

nslookup smpt.secureserver.net

non-authoritative answer:
name:	smtp.secureserver.net
address:	45.23.176.21

or

theforce.net	mail exchange	=	0	lightspeed.rcsntx.sbcglobal.net


## Mission 3

## Mission 4

## Mission 5

## Mission 6

## Mission 7


