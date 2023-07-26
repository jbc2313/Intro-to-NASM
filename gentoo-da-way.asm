    ; -------------------------------------------------------------------------
    ;
    ; To assemble and run:
    ;
    ;  nasm -felf64 gentoo-da-way.asm && ld gentoo-based.o && ./a.out
    ;
    ;
    ;--------------------------------------------------------------------------

        section .data
message:
        db  "Gentoo is da way", 10          ; message can be changed without updating in program

    
        global      _start

        section     .text
_start:
        mov         rbx, message            ; move address of message string into RBX
        mov         rax, rbx                ; move address in RBX into RAX as well (both need to point to same memory segment)

nextchar:
        cmp         byte [rax], 0           ; compare byte pointed at by RAX to 0 (0 is end of string delimiter)
        jz          finished                ; jump (if the zero flagged has been set) to finished section
        inc         rax                     ; increment the address in RAX by one byte (if 0 flag isnt set)
        jmp         nextchar                ; jump to section nextchar

finished:
        sub         rax, rbx                ; subtract RBX from RAX, result is number of segmets between them in bytes
                                            ; this works when memory addresses hold the same type

        mov         rdx, rax                ; RAX now equals the nmber of bytes in the string
        mov         rsi, message            ; rest should be a normal write
        mov         rax, 1                  ; syscall for write
        mov         rdi, 1                  ; file handle 1 for stdout
        syscall                             ;
        mov         rax, 60                 ; syscall for exit
        xor         rdi, rdi                ; exit code 0
        syscall                             ; invoke os to exit
