@echo off
cd C:\Clarify\clfysrvr.60\rulemgr
C:\Clarify\clfysrvr.60\rulemgr\cbbatch -f note.cbs -f log_cf.cbs -m log_cf.cbs -r log_cf -al %1 > c:\temp\log_cf_bat.txt
