; ---------------------------------------------------------------------------
; Question 3 - Add 32 students to the Web Design teaching group (15 + 32)
; Author : Farhan Ahmed Sahol
; Build  : nasm -f elf32 question03.asm -o question03.o && ld -m elf_i386 -e main question03.o -o question03
;
; Revised after submission: the result is now converted to text and printed
; from the register (the original printed a hard-coded "47").
; ---------------------------------------------------------------------------
global main

SECTION .data
    initial_count db 15                 ; current Web Design group size
    addition      db 32                 ; students being added
    msg           db "New Web Design group size: "
    msg_len       equ $ - msg
    newline       db 0xa

SECTION .bss
    total   resd 1                      ; stored result
    numbuf  resb 12

SECTION .text
main:
    movzx eax, byte [initial_count]     ; zero-extend 8-bit values into 32-bit registers
    movzx ebx, byte [addition]
    add   eax, ebx                      ; EAX = 15 + 32
    mov   [total], eax

    mov   ecx, msg
    mov   edx, msg_len
    call  write
    mov   eax, [total]
    call  print_uint
    mov   ecx, newline
    mov   edx, 1
    call  write

    xor   ebx, ebx                      ; exit(0)
    mov   eax, 1
    int   0x80

; write: ECX = address, EDX = length
write:
    push eax
    push ebx
    mov  ebx, 1
    mov  eax, 4
    int  0x80
    pop  ebx
    pop  eax
    ret

; print_uint: prints unsigned EAX in decimal
print_uint:
    push ebx
    push ecx
    push edx
    mov  ecx, numbuf + 11
    mov  ebx, 10
.digit:
    xor  edx, edx
    div  ebx
    add  dl, '0'
    dec  ecx
    mov  [ecx], dl
    test eax, eax
    jnz  .digit
    mov  edx, numbuf + 11
    sub  edx, ecx
    call write
    pop  edx
    pop  ecx
    pop  ebx
    ret
