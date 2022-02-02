## Week 5 Homework Submission File: Archiving and Logging Data

Please edit this file by adding the solution commands on the line below the prompt.

Save and submit the completed file for your homework submission.

---

### Step 1: Create, Extract, Compress, and Manage tar Backup Archives

1. Command to **extract** the `TarDocs.tar` archive to the current directory:

tar xf TarDocs.tar

2. Command to **create** the `Javaless_Doc.tar` archive from the `TarDocs/` directory, while excluding the `TarDocs/Documents/Java` directory:

tar cvf Javaless_Doc.tar --exclude="/home/sysadmin/Projects/TarDocs/Documents/Java" ~/Projects/TarDocs

3. Command to ensure `Java/` is not in the new `Javaless_Docs.tar` archive:

tar tf Javaless_Doc.tar |grep Java

**Bonus** 
- Command to create an incremental archive called `logs_backup_tar.gz` with only changed files to `snapshot.file` for the `/var/log` directory:

sudo tar cvvzf logs_backup.tar.gz --listed-incremental=logs_backup.snar --level=0 /var/log


#### Critical Analysis Question

- Why wouldn't you use the options `-x` and `-c` at the same time with `tar`?

they are two fundamentally different ways of using tar. -c creates the file whilst -x extracts an existing file. 
-c writes the file
-x xtracts the file
 

---

### Step 2: Create, Manage, and Automate Cron Jobs

1. Cron job for backing up the `/var/log/auth.log` file:

Step1: sudo contab -e

Step2: add this command to the crontab

0 6 * * 3 tar cvvzf /"$(date '+%F')_auth_backup.tgz" /var/log/auth.log

---

### Step 3: Write Basic Bash Scripts

1. Brace expansion command to create the four subdirectories:

mkdir -p  ~/backups/{freemem,diskuse,openlist,freedisk}

2. Paste your `system.sh` script edits below:
(script is in the "attached_files" folder)
   #!/bin/bash

# INSTRUCTIONS: Edit the following placeholder command and output filepaths
For example: cpu_usage_tool > ~/backups/cpuuse/cpu_usage.txt
The cpu_usage_tool is the command and ~/backups/cpuuse/cpu_usage.txt is the filepath
In the above example, the `cpu_usage_tool` command will output CPU usage information into a `cpu_usage.txt` file.
Do not forget to use the -h option for free memory, disk usage, and free disk space

Free memory output to a free_mem.txt file

free -h > ~/backups/freemem/"$(date '+%F_%H:%M')_free_mem.txt"

Disk usage output to a disk_usage.txt file

df -h > ~/backups/diskuse/"$(date '+%F_%H:%M')_disk_usage.txt"

List open files to a open_list.txt file

lsof > ~/backups/openlist/"$(date '+%F_%H:%M')_open_list_files.txt"

Free disk space to a free_disk.txt file

df -h /dev/sda1 > ~/backups/freedisk/"$(date '+%F_%H:%M')_free_disk.txt"



3. Command to make the `system.sh` script executable:

chmod +x system.sh


**Optional**
- Commands to test the script and confirm its execution:

./system.sh

ls -R ~/backups

**Bonus**
- Command to copy `system` to system-wide cron directory:

sudo cp system.sh /etc/cron.weekly

---

### Step 4. Manage Log File Sizes
 
1. Run `sudo nano /etc/logrotate.conf` to edit the `logrotate` configuration file. 

    Configure a log rotation scheme that backs up authentication messages to the `/var/log/auth.log`.

    - Add your config file edits below:

cd /etc/logrotate.d
sudo nano auth

     /var/log/auth.log {
         rotate 7
         weekly
         notifempty
         compress
         delaycompress
         missingok
         endscript
}
    
    ---

### Bonus: Check for Policy and File Violations

1. Command to verify `auditd` is active:

    systemctl status auditd

2. Command to set number of retained logs and maximum log file size:

sudo nano /etc/audit/auditd.conf


    - Add the edits made to the configuration file below:

    ```bash

    max_log_file = 35
    num_logs = 7

    ```

3. Command using `auditd` to set rules for `/etc/shadow`, `/etc/passwd` and `/var/log/auth.log`:

sudo nano /etc/audit/rules.d/audit.rules


    - Add the edits made to the `rules` file below:

    ```bash

    -w /etc/shadow -p wra -k hashpass_audit

    -w /etc/passwd -p wra -k userpass_audit

    -w /var/log/auth.log -p wra -k authlog_audit

    ```

4. Command to restart `auditd`:

    systemctl restart auditd

5. Command to list all `auditd` rules:

    sudo auditctl -l

6. Command to produce an audit report:
    sudo aureport -au

7. Create a user with `sudo useradd attacker` and produce an audit report that lists account modifications:

Report titled "account_modifications"
Located in "attached_files" 

8. Command to use `auditd` to watch `/var/log/cron`:

sudo auditctl -w /var/log/cron -p rwxa -k cron_tinkering_audit
this is a command to audit the cron directory, this command will not be persistent.

To make it persistent you need to do these steps:

Step1:    sudo nano /etc/audit/rules.d/audit.rules
Step2:    -w /var/log/cron -p rwxa -k cron_tinkering_audit
Step3:    Save the updated audit.rules file
Step4:    systemstl restart auditd



9. Command to verify `auditd` rules:

sudo auditctl -l

---

### Bonus (Research Activity): Perform Various Log Filtering Techniques

1. Command to return `journalctl` messages with priorities from emergency to error:

journalctl -p err -b



1. Command to check the disk usage of the system journal unit since the most recent boot:

journalctl --disk-usage


1. Comand to remove all archived journal files except the most recent two:

sudo journalctl --vacuum-time=2d

1. Command to filter all log messages with priority levels between zero and two, and save output to `/home/sysadmin/Priority_High.txt`:

journalctl -p 0..2 > /home/sysadmin/Priority_High.txt


1. Command to automate the last command in a daily cronjob. Add the edits made to the crontab file below:

Step1: nano priority_logs.sh

Step2: create bash script.
    
    #!/bin/bash

    journalctl -p 0..2 > /home/sysadmin/"$(date '+%F')_Priority_High_Logs.txt"
    

Step3: chmod +x priority_logs.sh

Step4: sudo mv priority_logs.sh /etc/cron.daily/

Script is in "attached_files"
---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
