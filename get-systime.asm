    ; -----------------------------------------------------------
    ; Lets use the syscall systime to return the time (SYSTIME is 201, sysinfo is 99)
    ;
    ; To assemble and run:
    ;
    ;  nasm -felf64 get-systime.asm && ld get-systime.o && ./a.out
    ;
    ;
    ;--------------------------------------------------------------
        %include    'util-func.asm'

        section .data
message:
        db  "Time elapsed in seconds since January 1, 1970: ", 0           ; message can be changed without updating in program

    
        global      _start

        section     .text
_start:
        mov         rax, message                                           ; load message in RAX
        call        stpr                                                   ; call our string printing function

        mov         rax, 201
        syscall

        call        intprlf                                                ; call our integer print function with linefeed
        call        quit
