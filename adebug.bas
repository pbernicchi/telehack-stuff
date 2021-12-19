 10  if argv$(1)="/skip" or argv$(1)="skip" then goto 40
 20  if th_hostname$="telehack (TEL/OS)" then print "%program incompatible with this host cpu" : end
 30  if instr(dir$,"pdebug.exe")=-1 then print "%pdebug.exe missing" : end
 40  start=th_time
 50  print "Getting Proccess List... ";
 60  th_exec "ps", ps$
 70  ps$=mid$(ps$,instr(ps$,"---"))
 80  ps$=mid$(ps$,instr(ps$,chr$(13))+3)
 90  ps$=left$(ps$,len(ps$)-2)
100  ps$=ps$+"."
110  pros=pros+1
120  ps$(pros)=left$(ps$,instr(ps$,chr$(13)))
130  ps$=mid$(ps$,instr(ps$,chr$(13))+3)
140  if ps$<>"." then goto 110
150  print "("+left$(str$(th_time-start),instr(str$(th_time-start),".")+3)+"s)"
160  print
170  for debugloop = pros to 1 step -1
180  tuser$=mid$(ps$(debugloop),8,9)
190  if left$(tuser$,len(user$))=user$ then goto 390
200  tps$=mid$(ps$(debugloop),2,5)
210  tname$=mid$(ps$(debugloop),24)
220  if instr(tname$," ")<>-1 then tname$=left$(tname$, instr(tname$," "))
230  print "Debugging ("+str$((pros+1)-debugloop)+"/"+str$(pros)+"):"
240  print "  Proccess: "+tname$
250  print "  PID: "+tps$
260  print "  User: "+tuser$
270  print
280  print "Running pdebug.exe... " : start=th_time
290  debugged=1
300  th_exec "run pdebug.exe "+tps$, xxx$
310  for dloop=1000 to 7777
320  th_exec "id", check$
330  if check$=user$+chr$(13)+chr$(10) then goto 370
340  print "  ";
350  th_exec "d "+str$(dloop)+" 100"
360  next dloop
370  print "Complete. ("+left$(str$(th_time-start),instr(str$(th_time-start),".")+3)+"s)"
380  print
390  next debugloop
400  if debugged=0 then print "No Proccesses to Debug" : end
410  print "Run Rooting Programs? (y/N)"; : key$=inkey$ : print
420  if key$<>"y" then end
430  os$=mid$(th_hostname$,instr(th_hostname$,"(")+2) : os$=left$(os$,instr(os$,")"))
440  print
450  print "Running "+os$+" Kit..." : th_exec "run "+os$+"kit.exe y", xxx$
460  print "Running Rootkit..." : th_exec "run rootkit.exe y", xxx$
470  print "Running Sentinel..." : th_exec "run sentinel.exe y", xxx$
480  print "Running Portblock..." : th_exec "run portblock.exe y", xxx$
490  print "Running Netlog..." : th_exec "run netlog.exe y",xxx$
500  print : print "Proccess Complete."