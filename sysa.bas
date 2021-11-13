 10  print "[0|1] ? " ;
 20  option = val(inkey$)
 30  if option <> 1 and option <> 0 then goto 20
 40  if option = 0 then print "disabling sysadm..."
 50  if option = 1 then print "enabling sysadm..."
 60  for i = 512 to 1e6
 70  if peek(i) = 255 and peek(i+1) = 255 then print "done" : goto 110
 80  u$ = ""
 90  if chr$(peek(i))+chr$(peek(i+1))+chr$(peek(i+2))+chr$(peek(i+3))+chr$(peek(i+4))+chr$(peek(i+5)) = chr$(0)+"user " then gosub 120
100  next i
110  end
120  u$ = chr$(peek(i+6))+chr$(peek(i+7))+chr$(peek(i+8))+chr$(peek(i+9))+chr$(peek(i+10))+chr$(peek(i+11))+chr$(peek(i+12))+chr$(peek(i+13))+chr$(peek(i+14))
130  if instr(u$," ") <> -1 then u$ = left$(u$,instr(u$," "))
140  if instr(u$,t$) <> -1 then gosub 160
150  return
160  for f = i to 1e6
170  if chr$(peek(f))+chr$(peek(f+1))+chr$(peek(f+2))+chr$(peek(f+3)) = "TVER" then gosub 200 : return
180  next f
190  return
200  poke f-1,option
210  return