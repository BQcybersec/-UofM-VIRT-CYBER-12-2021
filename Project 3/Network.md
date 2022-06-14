# Network Forensic Analysis Report



## Time Thieves 
You must inspect your traffic capture to answer the following questions:

1. What is the domain name of the users' custom site?
    `frank-n-ted.com`
2. What is the IP address of the Domain Controller (DC) of the AD network?
    `10.6.12.12`
![sourcenameandip](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.01.domainnameandip.png)
3. What is the name of the malware downloaded to the 10.6.12.203 machine?
    `june11.dll`
![nameofmalware](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.02.nameofmalware.png)
![downloadingmalware](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.03.downloadingmalware.png)
![downloadedmalware](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.04.downloadedmalware.png)

4. Upload the file to [VirusTotal.com](https://www.virustotal.com/gui/).
![fileanalysis](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.05.virustotalanalysis.png)

5. What kind of malware is this classified as?

`A trojan`
![trogan](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.06.trojan.png)

---

## Vulnerable Windows Machine

1. Find the following information about the infected Windows machine:
   
    - Host name: Rotterdam-PC.mind-hammer.net
  
![hostname](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.07.hostname.png)  

    - IP address: 172.16.4.205
  
![ipadd](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.08.ipadd.png)

    - MAC address: 00:59:07:b0:63:a4
  
![macadd](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.09.macadd.png)
    
1. What is the username of the Windows user whose computer is infected?

`matthijs.devries`

`ip.src==172.16.4.205 && kerberos.CNameString`

![username](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.10.username.png)

3. What are the IP addresses used in the actual infection traffic?

`185.243.115.84`
![ipaddinfectiontraffic](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.11.infectiontraffic.png)

4. As a bonus, retrieve the desktop background of the Windows host.

`export http object list`
![exportbackground](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.12.deskexport.png)
![desktopbackgroun](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.13.deskback.png)
---

## Illegal Downloads

1. Find the following information about the machine with IP address `10.0.0.201`:
    - MAC address: `00:16:17:18:66:c8`
    - Windows username: `elmer.blanco`
    - Computer host name: `BLANCO-DESKTOP`
`ip.addr==10.0.0.201 && kerberos.CNameString`
![torrenttraffic](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.14.torrenttraffic.png)

2. Which torrent file did the user download?
`Betty_Boop_Rhythm_on_the_reservation.avi.torrent`
![what torrent?](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Project%203/Images/network.15.whattorrent.png)

