; ---------------------------------------------------------------------------
; Question 2 - Label students by age:
;     prime age -> "ProTech"   (checked first: 19, 23, 29... are prime AND odd)
;     odd age   -> "SIMTech"
;     even age  -> "Smartstart"
; Author : Farhan Ahmed Sahol
; Build  : nasm -f elf32 question02.asm -o question02.o && ld -m elf_i386 -e main question02.o -o question02
;
; Revised after submission - bugs fixed:
;   1. Each string now has its own length computed straight after it
;      (originally len1 spanned all three strings, so several labels printed).
;   2. The dividend is zero-extended (movzx ax, ...) before DIV; the original
;      copied AL into AH, which corrupted the remainder used by the prime test.
;   3. Prime is checked before odd/even, so odd primes are labelled ProTech.
;   4. Runs over every age in the module's range (18-38) instead of one value,
;      printing "Age NN: <group>" so the logic can be checked at a glance.
; ---------------------------------------------------------------------------
global main

SECTION .data
    MIN_AGE     equ 18
    MAX_AGE     equ 38

    prefix      db "Age "
    prefix_len  equ $ - prefix
    sep         db ": "
    sep_len     equ $ - sep

    simtech     db "SIMTech", 0xa
    simtech_len equ $ - simtech
    smart       db "Smartstart", 0xa
    smart_len   equ $ - smart
    protech     db "ProTech", 0xa
    protech_len equ $ - protech

SECTION .bss
    numbuf      resb 12                 ; buffer for decimal conversion
    age         resd 1                  ; current age being classified

SECTION .text
main:
    mov  dword [age], MIN_AGE

next_age:
    ; ---- print "Age NN: " ----
    mov  ecx, prefix
    mov  edx, prefix_len
    call write
    mov  eax, [age]
    call print_uint
    mov  ecx, sep
    mov  edx, sep_len
    call write

    ; ---- classify ----
    mov  eax, [age]
    call is_prime                       ; returns AL = 1 if prime
    cmp  al, 1
    je   label_protech

    test dword [age], 1                 ; lowest bit set -> odd
    jnz  label_simtech

label_smart:
    mov  ecx, smart
    mov  edx, smart_len
    jmp  print_label
label_simtech:
    mov  ecx, simtech
    mov  edx, simtech_len
    jmp  print_label
label_protech:
    mov  ecx, protech
    mov  edx, protech_len
print_label:
    call write

    inc  dword [age]
    cmp  dword [age], MAX_AGE
    jle  next_age

    xor  ebx, ebx                       ; exit(0)
    mov  eax, 1
    int  0x80

; ---------------------------------------------------------------------------
; is_prime: EAX = n (0-255). Returns AL = 1 if n is prime, else AL = 0.
; Trial division by d = 2 .. n-1 (stops early when d*d > n).
; ---------------------------------------------------------------------------
is_prime:
    push ebx
    push ecx
    mov  ecx, eax                       ; ECX = n
    cmp  ecx, 2
    jb   .not_prime                     ; 0 and 1 are not prime
    mov  ebx, 2                         ; divisor d
.loop:
    mov  eax, ebx
    mul  ebx                            ; EAX = d*d (EDX cleared for small n)
    cmp  eax, ecx
    ja   .prime                         ; d*d > n -> no divisor found
    xor  edx, edx
    mov  eax, ecx                       ; dividend = n, zero-extended into EDX:EAX
    div  ebx                            ; EDX = n mod d
    test edx, edx
    jz   .not_prime
    inc  ebx
    jmp  .loop
.prime:
    mov  al, 1
    jmp  .done
.not_prime:
    xor  al, al
.done:
    pop  ecx
    pop  ebx
    ret

; ---------------------------------------------------------------------------
; write: ECX = address, EDX = length -> sys_write to stdout
; ---------------------------------------------------------------------------
write:
    push eax
    push ebx
    mov  ebx, 1
    mov  eax, 4
    int  0x80
    pop  ebx
    pop  eax
    ret

; ---------------------------------------------------------------------------
; print_uint: prints the unsigned 32-bit value in EAX in decimal
; ---------------------------------------------------------------------------
print_uint:
    push ebx
    push ecx
    push edx
    mov  ecx, numbuf + 11               ; fill the buffer from the right
    mov  ebx, 10
.digit:
    xor  edx, edx
    div  ebx                            ; EAX = EAX / 10, EDX = remainder
    add  dl, '0'
    dec  ecx
    mov  [ecx], dl
    test eax, eax
    jnz  .digit
    mov  edx, numbuf + 11
    sub  edx, ecx                       ; number of digits
    call write
    pop  edx
    pop  ecx
    pop  ebx
    ret
