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
