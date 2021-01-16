%include "io.inc"
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    
    GET_UDEC 4,eax
    GET_UDEC 4,ebx
    
    push eax
    ;push ebx
    mov edx,0
    call Log
    PRINT_UDEC 4,edx
    
Log:
    enter 0,0
    mov ecx,[ebp+8]
    mov eax, ecx
    mov edx, 0
    cmp ecx,1
    JA DIVI
    mov edx,0    ;edx vai ser o contador
    jmp END_Log  ;        
    
DIVI:
    sub eax,ebx
    inc edx
    cmp eax,0
    ja DIVI
    push edx
    call Log
    inc edx   
    
END_Log:    
    leave 
    ret 4