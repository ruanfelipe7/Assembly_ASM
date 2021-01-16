%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_UDEC 4, EAX 
    push EAX
    call Log2
    PRINT_UDEC 4, EBX
    xor eax, eax
    ret
    
Log2:
    enter 0,0
    mov EAX, [EBP+8]
    cmp EAX, 1
    ja Continua_Log
    mov EBX, 0
    jmp Final
    
    Continua_Log:
    mov EDX, 0
    mov ECX, 2
    div ECX
    push EAX
    call Log2
    inc EBX
    
Final:
    leave
    ret 4