global main                             ; must be declared for final compilation

SECTION .data                           ; data for the program
    comp_sci db 150                     ; Computer Science students
    cybersecurity db 49                 ; Cybersecurity students
    soft_eng db 43                      ; Software Engineering students
    web_design db 15                    ; Web Design students
    total_msg db "Total Students:239 ", 0xa
    total_len equ $ - total_msg

SECTION .bss
    total resb 1                        ; space to store the result

SECTION .text

main:
    mov al, [comp_sci]                  ; load computer science count
    add al, [cybersecurity]             ; add cybersecurity count
    add al, [soft_eng]                  ; add software engineering count
    add al, [web_design]                ; add web design count
    mov [total], al                     ; store result

    ; Print total message
    mov edx, total_len
    mov ecx, total_msg
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; Exit
    mov eax, 1
    int 0x80
