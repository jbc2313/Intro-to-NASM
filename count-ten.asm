;-------------------------------------------------------
; Count to ten printing the ascii value of integer
;
; To compile
;  nasm -felf64 count-ten.asm && ld count-ten.o && ./a.out
;
;--------------------------------------------------------

            %include                'util-func.asm'                     ; include external functions

            global                  _start
            section                 .text

_start:
            mov                     rcx, 0

nextNumber:
            inc                     rcx
            mov                     rax, rcx
            call                    intprlf                             ;  call our int printing function with linefeed
            cmp                     rcx, 10
            jne                     nextNumber

            call                    quit
