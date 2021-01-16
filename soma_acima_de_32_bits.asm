%include "io.inc"

section .bss
   res RESD 4

section .text
global CMAIN
CMAIN:
    mov ebp,       esp; for correct debugging
    ;write your code here
    mov esi, 12
    mov eax, 4294967295
    mov DWORD[res+esi] , eax
    mov EBX, 4294967295
    
    SOMA:
    add EAX, EBX
    jc pulo
    
    mov DWORD[res+esi], eax
    
    
    pulo:   
    mov DWORD[res+esi], eax
    sub esi, 4    
    mov eax, [res+esi]
    inc eax
    mov DWORD[res+esi],eax
    add esi, 4
    mov eax, [res+esi]
    
    PRINT_HEX 4, [res]
    PRINT_HEX 4, [res+4]
    PRINT_HEX 4, [res+8]
    PRINT_HEX 4, [res+12]
    NEWLINE
    
    jmp SOMA
    
    
 
    
    
    
    
    
    
    
    
    
    xor eax, eax
    ret