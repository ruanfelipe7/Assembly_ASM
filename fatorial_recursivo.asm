%include "io.inc"

section .text
global CMAIN
CMAIN:
    ;write your code here
    GET_UDEC 4, EDX
    push EDX
    call Fatorial
    PRINT_UDEC 4, EAX
    xor eax, eax
    ret
    
Fatorial:
    enter 0,0
    mov EBX, [EBP+8]
    cmp EBX, 1
    jnbe CONTINUE
    mov eax, 1
    jmp FIM
    
    CONTINUE:
    dec EBX
    push EBX
    call Fatorial
    mul DWORD[ebp+8]
    
FIM:     
    leave 
    ret 4     