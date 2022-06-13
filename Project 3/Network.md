# Network Forensic Analysis Report

_TODO_ Complete this report as you complete the Network Activity on Day 3 of class.

## Time Thieves 
You must inspect your traffic capture to answer the following questions:

1. What is the domain name of the users' custom site?
    frank-n-ted.com
2. What is the IP address of the Domain Controller (DC) of the AD network?
    10.6.12.12
![sourcenameandip](network.01.domainnameandip.png)
3. What is the name of the malware downloaded to the 10.6.12.203 machine?
    june11.dll
![nameofmalware](network.02.nameofmalware.png)
![downloadingmalware](network.03.downloadingmalware.png)
![downloadedmalware](network.04.downloadedmalware.png)

4. Upload the file to [VirusTotal.com](https://www.virustotal.com/gui/).
![fileanalysis](network.05.virustotalanalysis.png)

5. What kind of malware is this classified as?

A trojan
![trogan](network.06.trojan.png)

---

## Vulnerable Windows Machine

1. Find the following information about the infected Windows machine:
    - Host name: Rotterdam-PC.mind-hammer.net
![hostname](network.07.hostname.png)  

    - IP address: 172.16.4.205
![ipadd](network.08.ipadd.png)

    - MAC address: 00:59:07:b0:63:a4
![macadd](network.09.macadd.png)
    
2. What is the username of the Windows user whose computer is infected?
matthijs.devries

`ip.src==172.16.4.205 && kerberos.CNameString`

![username](network.10.username.png)

3. What are the IP addresses used in the actual infection traffic?

`185.243.115.84`
![ipaddinfectiontraffic](network.11.infectiontraffic.png)

4. As a bonus, retrieve the desktop background of the Windows host.

`export http object list`
![exportbackground](network.12.deskexport.png)
![desktopbackgroun](network.13.deskback.png)
---

## Illegal Downloads

1. Find the following information about the machine with IP address `10.0.0.201`:
    - MAC address: 00:16:17:18:66:c8
    - Windows username: elmer.blanco
    - Computer host name: BLANCO-DESKTOP
`ip.addr==10.0.0.201 && kerberos.CNameString`
![torrenttraffic](network.14.torrenttraffic.png)

2. Which torrent file did the user download?
`Betty_Boop_Rhythm_on_the_reservation.avi.torrent`
![what torrent?](network.15.whattorrent.png)

