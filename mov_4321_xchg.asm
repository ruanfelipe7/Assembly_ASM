%include "io.inc"

section .data
    array dw 1, 2, 3, 4

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    xor eax, eax
    mov ax, [array]
    xchg ax, [array+6]
    mov [array], ax
    mov ax, [array+2]
    xchg [array+4], ax
    mov [array+2], ax
    PRINT_DEC 2, array
    PRINT_DEC 2, array+2
    PRINT_DEC 2, array+4
    PRINT_DEC 2, array+6
    xor eax, eax
    ret