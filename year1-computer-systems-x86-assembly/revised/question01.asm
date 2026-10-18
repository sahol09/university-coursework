; ---------------------------------------------------------------------------
; Question 1 - Introduce myself to my mini-group and declare a constant (200)
; Author : Farhan Ahmed Sahol
; Build  : nasm -f elf32 question01.asm -o question01.o
;          ld -m elf_i386 -e main question01.o -o question01   (or: gcc -m32 question01.o -o question01)
; Revised after submission: program now exits with status 0 (ebx cleared before exit).
; ---------------------------------------------------------------------------
global main

SECTION .data
    msg         db "Hello, Group-C! I am Sahol, excited to collaborate.", 0xa
    len         equ $ - msg             ; length of the message (assembler-time constant)
    CONST_VALUE equ 200                 ; required constant equal to 200 (no memory used)

SECTION .text
main:
    mov  edx, len                       ; number of bytes to write
    mov  ecx, msg                       ; address of the message
    mov  ebx, 1                         ; file descriptor 1 = stdout
    mov  eax, 4                         ; sys_write
    int  0x80

    xor  ebx, ebx                       ; exit status 0
    mov  eax, 1                         ; sys_exit
    int  0x80
