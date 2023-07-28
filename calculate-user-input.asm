;-------------------------------------------------------
; Calculate user input from ascii values (switch to ints to add then switch back to ascii to print)
;
; To compile
;  nasm -felf64 calculate-user-input.asm && ld calculate-user-input.o && ./a.out 20 40 20
;
;--------------------------------------------------------

            %include            'util-func.asm'                     ; include external functions

            global              _start
            section             .text

_start:
            pop                 rcx                                 ; first value on stack is the number of args
            pop                 rdx                                 ; second value on the stack is the program name (discarded when we initialise RDX)
            sub                 rcx, 1                              ; decrease RCX by 1 ( number of args with out program name)
            mov                 rdx, 0                              ; initialize our data register to store additions

nextArgument:
            cmp                 rcx, 0                              ; check to see if we have any args left
            jz                  noMoreArguments                     ; if zero flag is set jump to noMoreArguments section
            pop                 rax                                 ; pop the next argument off the stack
            call                atoi                                ; convert our ascii string to decimal int
            add                 rdx, rax                            ; perform our addition logic
            dec                 rcx                                 ; decrease RCX (counter register for number of args left) by 1
            jmp                 nextArgument                        ; jump to next argument

noMoreArguments:
            mov                 rax, rdx                            ; move our data result into RAX for printing
            call                intprlf                             ; call our integer printing function with linefeed
            call                quit                                ; call our quit function
