global main                             ; must be declared for final compilation

SECTION .data                           ; data for the program
    age db 2                           ; student's age
    simtech db "SIMTech", 0xa           ; group for odd ages
    smartstart db "Smartstart", 0xa     ; group for even ages
    protech db "ProTech", 0xa           ; group for prime ages
    len1 equ $ - simtech                ; length of SIMTech
    len2 equ $ - smartstart             ; length of Smartstart
    len3 equ $ - protech                ; length of ProTech

SECTION .text

main:                                   ; program entry point
    mov al, [age]                       ; load age into AL
    test al, 1                          ; check if odd
    jz even_check                       ; jump to even_check if age is even
    mov edx, len1                       ; length of SIMTech
    mov ecx, simtech                    ; load SIMTech
    jmp display                         ; display result

even_check:
    mov bl, 2                           ; start divisor at 2
    mov cl, al                          ; copy age to CL for checking
prime_check:
    cmp bl, cl                          ; divisor >= age?
    jge prime                           ; if divisor >= age, it is prime
    mov ah, al                          ; divide age by divisor
    div bl
    cmp ah, 0                           ; check remainder
    je not_prime                        ; if zero, not a prime
    inc bl                              ; increment divisor
    jmp prime_check                     ; loop for next divisor

prime:
    mov edx, len3                       ; length of ProTech
    mov ecx, protech                    ; load ProTech
    jmp display

not_prime:
    mov edx, len2                       ; length of Smartstart
    mov ecx, smartstart                 ; load Smartstart

display:
    mov ebx, 1                          ; stdout
    mov eax, 4                          ; syscall for write
    int 0x80                            ; call kernel
    mov eax, 1                          ; syscall for exit
    int 0x80                            ; call kernel
