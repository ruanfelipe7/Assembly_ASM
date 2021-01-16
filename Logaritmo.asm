%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_UDEC 4, EAX
    GET_UDEC 4, ECX
    push EAX
    call Logaritmo
    PRINT_UDEC 4, EBX
    xor eax, eax
    ret
    
Logaritmo:
    enter 0,0
    mov EAX, [EBP+8]
    cmp EAX, 1
    ja Continua_Log
    mov EBX, 0
    jmp Final
    
    Continua_Log:
    mov EDX, 0 
    div ECX
    push EAX
    call Logaritmo
    inc EBX
    cmp EDX, 0
    je Final
    mov EDX, 0
    inc EBX
Final:
    leave
    ret 4