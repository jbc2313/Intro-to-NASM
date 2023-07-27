; ---------------------------------------------------------------------------
;
;  Utility functions that are reused frequently, we can pull them out and
;  create a seperate file to clean up the actual program code.
;
;  Difference between x86 (E) and x86-64 (R),
;  RDI,RSI,RDX,
;  EBX,ECX,EDX
;----------------------------------------------------------------------------

;------------------------------------------------------
; int stln(String message)
;
; calculates the length of a String
;-------------------------------------------------------

stln:
    push        rbx
    mov         rbx, rax

nextchar:
    cmp         byte [rax], 0
    jz          finished
    inc         rax
    jmp         nextchar

finished:
    sub         rax, rbx
    pop         rbx
    ret

;------------------------------------------------------
; void stpr(String message)
;
; prints the String to stdout
;-------------------------------------------------------

stpr:
    push        rdx
    push        rcx
    push        rbx
    push        rax
    call        stln

    mov         rdx, rax
    pop         rax

    mov         rsi, rax
    mov         rax, 1
    mov         rdi, 1
    syscall

    pop         rbx
    pop         rcx
    pop         rdx
    ret


;--------------------------------------------------------
;  void stprlf(String message)
;
;  String print with linefeed function added
;--------------------------------------------------------

stprlf:
    call        stpr

    push        rax             ; push rax on stack to preserve it while we use rax in this function
    mov         rax, 10         ; move 10 into rax - 10 is the ascii char for linefeed
    push        rax             ; push linefeed on stack so we can get mem address of it
    mov         rax, rsp        ; move the address of the current stacfk pointer into rax for stpr function
    call        stpr            ; call String Print function with linefeed
    pop         rax             ; remove linefeed char from stack
    pop         rax             ; restore original value of rax before function was called
    ret


;------------------------------------------------------
; void exit()
;
; exit program
;-------------------------------------------------------

quit:
    mov         rax, 60
    xor         rdi, rdi
    syscall
    ret
