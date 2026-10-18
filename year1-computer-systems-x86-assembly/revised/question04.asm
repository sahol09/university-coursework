; ---------------------------------------------------------------------------
; Question 4 - Sum the students in all computing undergraduate programmes
;     Computer Science 150 + Cybersecurity 49 + Software Engineering 43 + Web Design 15
; Author : Farhan Ahmed Sahol
; Build  : nasm -f elf32 question04.asm -o question04.o && ld -m elf_i386 -e main question04.o -o question04
;
; Revised after submission - bugs fixed:
;   1. The correct total is 257 (the original message said 239).
;   2. 257 does not fit in an 8-bit register (max 255): the original sum in AL
;      wrapped round to 1. Values are now zero-extended and added in EAX.
;   3. The computed total is printed, not a hard-coded string.
; ---------------------------------------------------------------------------
global main

SECTION .data
    departments  db 150, 49, 43, 15      ; CS, Cybersecurity, SE, Web Design
    DEPT_COUNT   equ $ - departments
    msg          db "Total students: "
    msg_len      equ $ - msg
    newline      db 0xa

SECTION .bss
    total   resd 1
    numbuf  resb 12

SECTION .text
main:
    xor   eax, eax                      ; running total
    xor   esi, esi                      ; index
.sum:
    movzx ebx, byte [departments + esi]
    add   eax, ebx
    inc   esi
    cmp   esi, DEPT_COUNT
    jl    .sum
    mov   [total], eax                  ; 257

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
