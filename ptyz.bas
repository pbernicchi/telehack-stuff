' PTY.BAS -- PTYCON helper

' By ZCJ
    

    pty_usage$ = "%usage: run " + argv$( 0 ) + " [line|command] [-e|-f=<file>|-h|-l|-q]" ' edit if necessary

  ' argparse

    for a = 1 to argc%
        argv$( a ) = th_sed$( argv$( a ) , "^(-?-|\/)" ) ' parse args
        if th_re( argv$( a ) , "^((h(elp)?)|\?)$" ) then : goto 2 ' should be self-explanatory
        if th_re( argv$( a ) , "^e(xit)?$" )        then : exitpty = 1 ' exit pty after whatever else is done
        if th_re( argv$( a ) , "^q(uit)?$" )        then : exitpty = 1 ' see above
        if th_re( argv$( a ) , "^l(ist)?$" )        then : listpty = 1 ' list lines
        if th_re( argv$( a ) , "^(le|el)$" )        then : exitpty = 1 : listpty = 1 ' all of the above
        if th_re( argv$( a ) , "^f(ile)?\=" )       then : pty_in$ = th_sed$( argv$( a ) , "f(ile)?\=" ) : pty_in = 1 ' grab file if applicable, tell prog that there's a file in the first place
        if th_re( argv$( a ) , "^\d+$" )            then : line$ = argv$( a ) : isline = 1 ' grab line, yes this only does the last line in a series.  should fix that
        if th_re( argv$( a ) , "^(dx|rx)$" )        then : sx = a ' same as ^ but whether dx / rx; grab `a` so we know where to start the dx / rx
    next

    th_exec "call 666218"

    sleep 0.1

    if pty_in then : gosub 5 ' file check, get cmds

    gosub 4 ' list

    if not fnf and pty_in then : gosub 8 ' exec from file

    if sx then : goto 1 ' dx / rx

    if isline then : th_exec "attach " + line$

    gosub 3 ' exit check

    end
    
  ' subs

1 ' dx / rx

    th_exec argv$( sx ) + " " + argv$( sx + 1 ) + " " + argv$( sx + 2 )

    gosub 3

    end
  
2 ' %usage

    if not pty_in then : & lin( 1 ) pty_usage$
                         & 
                         & " -e, --exit" , "exit after running other commands"
                         & " -l, --list" ,              "list available lines"
                         & " -le, -el"   ,                    "both -e and -l"
                         & " -f=<file>"  ,         "read commands from a file"
                         &
                         & " Argument order is nonstrict."
                         &
                         & " Arguments can be prepended by a single"
                         & " slash, a single dash, or a double dash,"
                         & " or nothing at all." 
                         &
                         & " Run without args to simply enter ptycon."
                         &
                         end

3   if exitpty then : th_exec "exit" ; out$

    return

4   if listpty then : th_exec "list"

    return

5 ' get cmds from file

    if pty_in$ = "" then : & ups$( "pty: please specify a file" ) : end

    if not th_re( dir$ , "\b" + pty_in$ + "\b" ) then : & ups$( "pty: file '" + pty_in$ + "' not found" ) : return : fnf = 1

    & ">>> READING FROM FILE '" pty_in$ "'..." : &

    open pty_in$ , as #1

6   if typ( 1 ) = 3 then : goto 7

    input# 1 , cmds$( cmd_count ) 

    cmd_count = cmd_count + 1

    goto 6

7   close #1

    return

8 ' exec cmds from file

    for i = 0 to cmd_count
        th_exec cmds$( i )
        sleep 0.1
    next
    
    return


'   TODO -- Stuff to be written ... sometime


'     [ ] -- Add the ability to attach to multiple lines (pty 1 27)

'     [ ] -- Attach after dx / rx

'     [x] -- Fix wonky linenums

'     [ ] -- Improve %usage

'     [ ] -- dx / rx multiple times, e.g., `pty dx 1 2 rx 3 4`
