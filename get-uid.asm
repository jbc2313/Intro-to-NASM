    ; -----------------------------------------------------------
    ; Lets use the syscall systime to return the time (uid is 102)
    ;
    ; To assemble and run:
    ;
    ;  nasm -felf64 get-uid.asm && ld get-uid.o && ./a.out
    ;
    ;
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

        mov         rax, 102
        syscall

        call        intprlf                                                ; call our integer print function with linefeed
        call        quit
