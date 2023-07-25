    ; --------------------------------------------------------------------
    ; Write "Gentoo is Based" to the console using only system
    ; To assemble and run:
    ;
    ;
    ;   nasm -felf64 gentoo-based.asm && ld gentoo-based.o && ./a.out
    ;
    ; ---------------------------------------------------------------------


            global      _start

            section     .text
_start:     mov         rax, 1              ; system call for write
            mov         rdi, 1              ; file handle 1 is stdout
            mov         rsi, message        ; address of string to output
