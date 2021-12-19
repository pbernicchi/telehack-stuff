 10  clear$=chr$(27)+"[2K"+chr$(27)+"[1A"
 20  print chr$(27)+"[1A"+clear$
 30  if argv$(1)="" then input "User: ", usertarget$
 40  if argv$(1)<>"" then usertarget$=argv$(1)
 50  th_exec "finger", finger$
 60  if instr(finger$,usertarget$)=-1 then print "%user offline" : end
 70  print "Dumping Memory...";
 80  start=th_time
 90  for tableloop = 1 to 50000
100  table$=table$+chr$(peek(tableloop))
110  next tableloop
120  dtime$=str$(th_time-start)
130  print clear$ : print "Memory Dumped! ("+left$(dtime$,instr(dtime$,".")+2)+"s)"
140  if instr(table$,usertarget$)=-1 then print "%unknown error: user not found in memory dump" : end
150  table$=mid$(table$,instr(table$,usertarget$)+1)
160  table$=mid$(table$,instr(table$,"CORE ")+6)
170  table$=left$(table$,instr(table$,"CONN")-1)
180  if instr(table$,"QUEST")<>-1 then table$=left$(table$,instr(table$,"QUEST")-1)
190  table$=table$+" "
200  if len(table$)=0 then goto 250
210  progs=progs+1
220  prog$(progs)=left$(table$,instr(table$," "))
230  table$=mid$(table$,instr(table$," ")+2)
240  goto 200
250  if progs=1 and len(prog$(1))=0 then print : print usertarget$+" is running no programs." : goto 440
260  print : print "User "+usertarget$+": "+str$(progs)+" background proccesses"
270  print
280  print "Program   Description"
290  print "-------   -----------"
300  for printloop = 1 to progs
310  print prog$(printloop)+string$(10-len(prog$(printloop))," ");
320  if prog$(printloop)="autologin" then print "Send Login Credentials Automatically" : goto 430
330  if prog$(printloop)="ftpd" then print "TEL/OS FTP Server" : goto 430
340  if prog$(printloop)="iptun" then print "L2TP over PPP Daemon" : goto 430
350  if prog$(printloop)="osprober" then print "Sniff Remote OS Vendor" : goto 430
360  if prog$(printloop)="pppd" then print "Point-to-Point Protocol Daemon" : goto 430
370  if prog$(printloop)="ptyhide" then print "Cloaking Module for PTYCON Line 27" : goto 430
380  if prog$(printloop)="syslogd" then print "System Logging Daemon" : goto 430
390  if prog$(printloop)="unlink" then print "Link+Advise Blocker" : goto 430
400  if prog$(printloop)="xmodem" then print "XMODEM/CRC support kit" : goto 430
410  if prog$(printloop)="zcheat" then print "Interactive Z-code Modifier" : goto 430
420  print "%undoccumented"
430  next printloop
440  print
450  print "Note: Even if "+usertarget$+" is running syslogd.exe they will NOT be notified."