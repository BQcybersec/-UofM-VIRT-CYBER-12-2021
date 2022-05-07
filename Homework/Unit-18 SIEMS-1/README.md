## Unit-18 SIEMS
SPLUNK


### Step1:

#### Using the eval command, create a field called ratio that shows the ratio between the upload and download speeds.

    `source=server_speedtest.csv |eval Ratio = 'DOWNLOAD_MEGABITS' / 'UPLOAD_MEGABITS'`

#### Create a report using the Splunk's table command 

    `source="server_speedtest.csv" |eval Ratio = 'DOWNLOAD_MEGABITS' / 'UPLOAD_MEGABITS' |table TEST_DATE IP_ADDRESS DOWNLOAD_MEGABITS UPLOAD_MEGABITS Ratio`

![SpeedTest Report](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/01.SpeedTest%20Report.png)

#### Two Questions
	1. Based on the report created, what is the approximate date and time of the attack?
   
		- 2/23/2020 @ 2:30pm
  
	2. How long did it take your systems to recover?
   
         - The systems recovered by 2/23/2020 @ 11:30 pm But they recovered with a significantly higher upload speed which seems suspicious.


### Step2:

#### Create a report that shows the count of critical vulnerabilities from the customer database server.

    `source="nessus_logs.csv" dest_ip="10.11.36.23" severity=critical`

![create a report](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/02.createareport.png)

![report created](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/03.reportcreated.png)

#### Build an Alert

![build an alert](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/04.criticalvulnalert.png)

![critical vulnerabilities message](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/05.CriticalVulnMessage.png)


### Step3:

#### When did the attack occur?

        - The attack began Friday Febuary 21st 2020 at aprox 8 am and continued until 2pm that same day.
    

#### Determine a baseline of normal activity and a threshold that would alert if a brute force attack is occurring.

        - I would put the baseline at around 25 failed logins within an hour.
        - I would put the threshold at 30 failed logins per hour
    
#### Design an alert to check the threshold every hour and email the SOC team at SOC@vandalay.com if triggered.

![design an alert](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/06.Design%20an%20Alert1.png)

![design an alert](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/07.Designanalert2.png)
    
![design an alert](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-18%20SIEMS-1/Images/08.Designanalert3.png)





