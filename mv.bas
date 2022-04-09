   REM This was originally by gunpointg please consider getting ‍⁤‍⁢‍⁡‍⁣⁡‍⁢‍⁡‍⁢‍⁡‌‍⁤‍⁢‍⁡‍⁣⁡‌‍⁡⁢‌‍⁡this through gun's bbs! You can use gunsbbs.bas in telehack to get there.
   10  if instr(dir$,argv$(1))=-1 then print "%file not found" : end
   20  for checkloop=1 to 2
   30  if right$(argv$(checkloop),4)=".exe" then goto 90
   40  if right$(argv$(checkloop),4)=".gam" then goto 90
   50  if right$(argv$(checkloop),4)=".a2" then goto 90
   60  if right$(argv$(checkloop),4)=".vt" then goto 90
   70  if right$(argv$(checkloop),4)=".a2sav" then goto 90
   80  goto 100
   90  print "%invalid file type" : end
   100  if argv$(1)="/help" then print "mv - move file (rename)" : goto 120
   110  if argv$(1)<>"" and argv$(2)<>"" then goto 130
   120  print "%usage: "+argv$(0)+" <source-file> <target-file>" : end
   130  open argv$(1), as #1
   140  open argv$(2), as #2
   150  if eof(1)=-1 then print "%file invalid, cannot move 0 bytes" : end
   160  if eof(2)<>-1 then print "%already exists, cannot overwrite" : end
   170  print "Moving "+chr$(34)+argv$(1)+chr$(34)+" -> "+chr$(34)+argv$(2)+chr$(34)
   180  if eof(1)=-1 then goto 230
   190  input# 1, fprint$
   200  if fprint$="" then fprint$=chr$(0)
   210  print# 2, fprint$
   220  goto 180
   230  close #1 : close #2
   240  th_exec "delete "+argv$(1), xxx$
   250  th_exec "l | grep "+argv$(2), l$
   260  size$=str$(cint(val(str$(val(mid$(l$,35,6))+0)+"."+mid$(l$,41,1))))
   270  print "Done ("+size$+" KB moved)
