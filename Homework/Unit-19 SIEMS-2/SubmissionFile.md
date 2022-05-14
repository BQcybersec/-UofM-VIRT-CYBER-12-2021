## Homework Unit 19

### Part 1: Windows Server Attack


#### Question 1

Several users were impacted during the attack on March 25th.
Based on the attack signatures, what mitigations would you recommend to protect each user account? 
Provide global mitigations that the whole company can use and individual mitigations that are specific to each user.
	
##### Company Wide 
  
Normal User Activity

![baseline active users](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/01.BaselineActiveUsers.png)

The attack shows a large increase in activity from select users

![attack active users](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/02.AttackActiveUsers.png)       

![baseline activity all users](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/03.baselineuseractivity.png)

        - Trigger an alert if an individual account has more than 25 failed login attempts
        - Also set up a required two-factor authentication for each account incase of another brute force attack.

One user was responsible for locking the accounts, locking them out would solve the issue.

![account lockouts](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/04.accountlockouts.png)

![single responsible user](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/05.accountlockouts2.png)
       
        
        - Set up a condition that a password can only be changed twice in a 24-hour period for a single account.

![password limit](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/06.password1.png)

![password limit](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/07.password2.png) 
 
		- A maximum limit of successful logins may also be needed, trigger an alert after 25 Logins for notice of suspicious activity. 

![successfuly login](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/08.login1.png)

![successfuly login](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/09.login2.png) 

##### Individual Account Actions
        
        - I would reccomend all three of the accounts involved in the attack change their login credentials immediately.

#### Question 2

VSI has insider information that JobeCorp attempted to target users by sending "Bad Logins" to lock out every user.
What sort of mitigation could you use to protect against this?

	- A single user per IP address would address this issue. 
          That way a single attacker would be unable to shut every user out of their accounts. 
        
        - Or changing all of the user names so the attackers wont have a pre-existing list of potential targets.

### Part 2: Apache Webserver Attack:

#### Question 1

Based on the geographic map, recommend a firewall rule that the networking team should implement.
Provide a "plain english" description of the rule.

    - You could block all incomming traffic from Kiev and Kharkiv after a certain threshold of activity has been reached.


Provide a screen shot of the geographic map that justifies why you created this rule.

Baseline of activity by country

![baseline](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/10.baselinebycountry.png)

Activity by country durning the attack

![attack](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/11.attackbycountry.png)

Activity by city during the attack

![city information](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/12.attackbyregion.png)


#### Question 2


VSI has insider information that JobeCorp will launch the same webserver attack but use a different IP each time in order to avoid being stopped by the rule you just created.


What other rules can you create to protect VSI from attacks against your webserver?

	- A threshold set by volume of traffic from an individual non-authorized IP address that can be triggered to block the IP address if it crosses the threshold.
        
        - The IP count goes way up during the attack and several of the addresses are not present from the baseline let alone with that level of activity. 

Baseline IP stats

![ip baseline](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/13.IPbaseline.png)

IP stats during the attack

![ip thresholds](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/14.IPduringattack.png)
        
        
        - Block non-authorized IP addresses that cross a POST request threshold.

![http methods baseline](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/15.httpmethodsbaseline.png)

![http methods during attack](https://github.com/BQcybersec/-UofM-VIRT-CYBER-12-2021/blob/main/Homework/Unit-19%20SIEMS-2/Images/16.httpmethodsduringattack.png)




