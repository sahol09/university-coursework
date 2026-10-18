global main                             ; must be declared for final compilation

SECTION .data                           ; data for the program
    initial_count db 15                 ; initial web design student count
    addition db 32                      ; number to add
    result_msg db "New Web Design Group Size:47", 0xa
    result_len equ $ - result_msg

SECTION .bss
    total resb 1                        ; space to store the result

SECTION .text

main:
    mov al, [initial_count]             ; load initial count
    add al, [addition]                  ; add 32 students
    mov [total], al                     ; store result

    ; Print result message
    mov edx, result_len
    mov ecx, result_msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Exit
    mov eax, 1
    int 0x80
