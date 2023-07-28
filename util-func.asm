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


;--------------------------------------------------------
;  void intpr(Integer number)
;
;  Function to print out Integers as Ascii (itoa)
;--------------------------------------------------------

intpr:
    push        rax             ; push RAX to stack to preserve
    push        rcx             ; push RCX to stack to preserve
    push        rdx             ; push RDX to stack to preserve
    push        rsi             ; push RSI to stack to preserve
    mov         rcx, 0          ; counter of how many bytes we need to print at the end

divLoop:
    inc         rcx             ; count each byte to print - number of chars
    mov         rdx, 0          ; empty RDX
    mov         rsi, 10         ; mov 10 into RSI
    idiv        rsi             ; divide RAX by RSI
    add         rdx, 48         ; convert value in RDX to its ascii number - RDX holds the remainder after a divide instruction
    push        rdx             ; push RDX, the String rep/ ascii number to the stack
    cmp         rax, 0          ; can the int be divided anymore
    jnz         divLoop         ; jump if not zero back to top of divLoop

prLoop:
    dec         rcx             ; count down each byte that we put on stack
    mov         rax, rsp        ; mov the stack pointer into rax for printing
    call        stpr            ; call String print function without linefeed
    pop         rax             ; remove last char from stack to move RSP forward
    cmp         rcx, 0          ; check if we printed all bytes we pushed onto stack
    jnz         prLoop          ; jump if not zero back to top of print loop

    pop         rsi             ; restore from stack
    pop         rdx             ; restore from stack
    pop         rcx             ; restore from stack
    pop         rax             ; restore from stack
    ret

;--------------------------------------------------------
;  void intprlf(Integer number)
;
;  Integer print with linefeed function added
;--------------------------------------------------------

intprlf:
    call        intpr           ; call our int printing function

    push        rax             ; push RAX onto the stack to preserve
    mov         rax, 10         ; push linefeed char into RAX
    push        rax             ; push the linefeed onto the stack so we can get the address
    mov         rax, rsp        ; move the address of the current stack pointer into RAX for stpr function
    call        stpr            ; call our string printing function
    pop         rax             ; remove the linefeed from the stack
    pop         rax             ; restore original value in RAX
    ret

;-----------------------------------------------------------
; int atoi(Integer number)
;
; function to convert Ascii to integer (atoi)
;-------------------------------------------------------------

atoi:
    push        rbx             ; push to stack to preserve
    push        rcx             ; push to stack to preserve
    push        rdx             ; push to stack to preserve
    push        rsi             ; push to stack to preserve
    mov         rsi, rax        ; move pointer in RAX into RSI (our number to convert)
    mov         rax, 0          ; init RAX with decimal value 0
    mov         rcx, 0          ; init RCX with dec value 0

.multiplyLoop:
    xor         rbx, rbx        ; reset both uber and lower bytes of RBX to 0
    mov         bl, [rsi+rcx]   ; move a single byte into RBX registers lower half
    cmp         bl, 48          ; compare RBX register lower half value against ascii value 48 (char value 0)
    jl          .finished       ; if less than, jump to finished
    cmp         bl, 57          ; compare RBX lower half against ascii value 57 (char value 9)
    jg          .finished       ; if greater than, jump to finished

    sub         bl, 48          ; convert RBX register lower half to decimal representaion of ascii value
    add         rax, rbx        ; add RBX to our int value in RAX
    mov         rbx, 10         ; move decimal value 10 into RBX
    mul         rbx             ; multiply RAX by RBX to ge place value
    inc         rcx             ; increment RCX ( counter register )
    jmp         .multiplyLoop   ; continue muliply Loop

.finished
    cmp         rcx, 0          ; compare RCX register value against decimal 0 (our counter register is RCX)
    je          .restore        ; if equal to 0, jump to .restore section ( no integer args were passed to atoi )
    mov         rbx, 10         ; move decimal value 10 in RBX
    div         rbx             ; dive RAX by value 10 in RBX

.restore
    pop         rsi             ; restore the values pushed onto stack to preserve while we worked
    pop         rdx             ; * ---
    pop         rcx             ; * ---
    pop         rbx             ; * Same  as above ^^^^
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
