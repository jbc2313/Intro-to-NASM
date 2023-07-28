;-------------------------------------------------------
; Calculate user input from ascii values (switch to ints to add then switch back to ascii to print)
;
; To compile
;  nasm -felf64 calculate-user-input.asm && ld calculate-user-input.o && ./a.out
;
;--------------------------------------------------------

            %include                'util-func.asm'                     ; include external functions

            global                  _start
            section                 .text

_start:
