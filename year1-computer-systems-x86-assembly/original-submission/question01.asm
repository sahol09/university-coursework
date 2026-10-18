global main                             ; must be declared for final compilation

SECTION .data                           ; data for the program
    msg db "Hello,Group-C! I am [Sahol], excited to collaborate.", 0xa
    const_value equ 200                 ; declare constant value
    len equ $ - msg                     ; length of the string

SECTION .text

main:                                   ; program entry point
    mov edx, len                        ; load message length into edx register
    mov ecx, msg                        ; load memory location of message into ecx register
    mov ebx, 1                          ; set to write to stdout
    mov eax, 4                          ; syscall for write
    int 0x80                            ; call kernel
    mov eax, 1                          ; syscall for exit
    int 0x80                            ; call kernel
