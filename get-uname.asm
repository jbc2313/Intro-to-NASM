    ; -----------------------------------------------------------
    ; Lets use the syscall systime to return the time (uid is 102)
    ;
    ; To assemble and run:
    ;
    ;  nasm -felf64 get-uname.asm && ld get-uname.o && ./a.out
    ;
    ;  THIS IS NOT WORKING CURRENTLY
    ;--------------------------------------------------------------
        %include    'util-func.asm'

        section .data
message:
        db  "System info:", 0           ; message can be changed without updating in program

    
        global      _start

        section     .text
_start:
        mov         rax, message                                           ; load message in RAX
        call        stpr                                                   ; call our string printing function

        mov         rax, 63
        syscall

        call        stln                                               ;
        call        quit
