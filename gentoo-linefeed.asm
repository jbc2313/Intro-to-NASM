; ---------------------------------------------------------------------
;  String Print with linefeed
;
;  compile with nasm -felf64 gentoo-linefeed.asm && ld gentoo-linefeed.o && ./a.out
;
;-----------------------------------------------------------------------


        %include            'util-func.asm'                     ; include external util-functions file

        section             .data
message1:
        db                  "Gentoo was started in 1999", 0     ; Removed the line feed char "10"
message2:
        db                  "Yes, Gentoo is older then Arch", 0 ; Removed the line feed char "10"


        global              _start

        section             .text
_start:
        mov                 rax, message1                       ; load message1 into RAX register
        call                stprlf                              ; Calling the new String print with linefeed

        mov                 rax, message2
        call                stprlf                              ; new String print with linefeed

        call                quit
