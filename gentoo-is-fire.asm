;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;
;  Another simple program to output to stdout, this time with an external file
;  with reusable functions
;
;  To assemble and run:
;
;  nasm -felf64 gentoo-is-fire.asm && ld gentoo-is-fire.o && ./a.out
;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


        %include        'util-func.asm'                 ; include external util-functions file

        section         .data
message1:
        db              "Gentoo is fire af", 10
message2:
        db              "You need to compile", 10

        global          _start

        section         .text
_start:
        mov             rax, message1                   ; move message1 to RAX
        call            stpr                            ; call our string printing function

        mov             rax, message2                   ; move message2 to RAX
        call            stpr                            ; call our string print function again

        call            quit                            ; call our exit program function
