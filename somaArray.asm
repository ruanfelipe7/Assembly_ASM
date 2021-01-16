


section .bss
    res RESD 1

section .text
global somaArray
somaArray:
    
    push ECX
    push EBX	
    mov ECX, [ESP+16]
    mov EBX, [ESP+12]
    pushad
    pushfd
    mov EAX, 0
    mov ESI, 0
    L1:
        add EAX, [EBX]
        add EBX, 4
        loop L1
    mov DWORD [res], EAX    
    popfd       
    popad
    pop EBX
    pop ECX 
    mov EAX, [res]
    ret
