%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    
    GET_UDEC 2, AX
    GET_UDEC 2, BX
    GET_UDEC 2, CX
    
    call TRIANGULO
    jz NAOEHTRIANGULO
    
    EHTRIANGULO:
        PRINT_STRING "EH TRIANGULO"
        call TIPODETRIANGULO
        jmp FINAL
        
    NAOEHTRIANGULO:
        PRINT_STRING "NAO EH TRIANGULO"
           
    
    FINAL: 
    xor eax, eax
    ret
   
TRIANGULO:
    cmp AX, 0
    je NAOTRIANGULO
    cmp BX, 0
    je NAOTRIANGULO
    cmp CX, 0
    je NAOTRIANGULO
    mov DX, BX
    add DX, CX
    cmp AX, DX
    ja NAOTRIANGULO
    mov DX, AX
    add DX, CX
    cmp BX, DX
    ja NAOTRIANGULO
    mov DX, AX
    add DX, BX
    cmp CX, DX
    ja NAOTRIANGULO
    
    ret
      
    NAOTRIANGULO:
    test al, 0
    ret
    
TIPODETRIANGULO:
    EQUILATERO:
    cmp AX, BX
    jne ISOSCELES1
    cmp BX, CX
    jne ISOSCELES2
    
    NEWLINE
    PRINT_STRING "EQUILATERO"
    jmp FIM
    
    ISOSCELES1:        
    cmp BX, CX
    jne ISOSCELES3
    
    
    ISOSCELES2:
        NEWLINE
        PRINT_STRING "ISOSCELES"    
        jmp FIM
        
    ISOSCELES3:
    cmp AX, CX
    je ISOSCELES2
    
    
    ESCALENO:
    NEWLINE
    PRINT_STRING "ESCALENO"
    FIM:
    ret
    
     