# x86 Assembly (NASM): Computer Systems Coursework

**Module:** CMPC102 Computer Systems, Year 1 (2024–25), University of Roehampton  
**Language:** 32-bit x86 assembly (NASM), Linux `int 0x80` system calls

## Brief (summary)
A university module scenario with 200+ students across four computing departments
(Computer Science 150, Cybersecurity 49, Software Engineering 43, Web Design 15). Write NASM programs to:

1. Print an introduction to my mini-group and declare a constant equal to 200
2. Label students by age: **SIMTech** (odd), **Smartstart** (even), **ProTech** (prime)
3. Add 32 students to the Web Design group
4. Sum the students in all four departments
5. Draw flowcharts for questions 2 and 4

## Contents
| Folder | What it is |
|---|---|
| [`original-submission/`](original-submission) | The four `.asm` files and two flowcharts exactly as submitted in Nov 2024 |

## Build and run (Linux)
```bash
nasm -f elf32 question01.asm -o question01.o
ld -m elf_i386 -e main question01.o -o question01   # or: gcc -m32 question01.o -o question01
./question01
```

## Concepts used
Registers (`EAX`–`EDX`, `AL`/`AH`), `.data` / `.bss` / `.text` sections, `equ` constants,
`mov` / `add` / `div` / `test` / `cmp`, conditional jumps (`jz`, `jge`, `je`), loops, Linux syscalls
`sys_write` and `sys_exit`.
