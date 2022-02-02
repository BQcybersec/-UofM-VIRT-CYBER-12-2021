#!/bin/bash

journalctl -p 0..2 > /home/sysadmin/"$(date '+%F')_Priority_High_Logs.txt"
