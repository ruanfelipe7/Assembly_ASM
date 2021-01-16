%include "io.inc"

section .data
    TabelaSelecao DD 1
    DD Caso1
    TamIntervalo EQU ($ - TabelaSelecao)
    DD 2
    DD Caso2
    DD 3
    DD Caso3
    DD 4
    DD Caso4
    NumerodeEntradas EQU ($ - TabelaSelecao) / TamIntervalo
    msgC1 DB "Caso de teste do numero 1", 0
    msgC2 DB "Caso de teste do numero 2", 0
    msgC3 DB "Caso de teste do numero 3", 0
    msgC4 DB "Caso de teste do numero 4", 0
    msgOC DB "Caso Indefinido",0
        

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_UDEC 4, EAX
    mov EBX, TabelaSelecao
    mov ECX, NumerodeEntradas
    
    LOOP1:
        cmp EAX, [EBX]
        jne LOOP2
        call [EBX + 4]
        PRINT_STRING [EDX]
        jmp LOOP3
    LOOP2:
        add EBX, TamIntervalo
        dec ECX
        jnz LOOP1
        call OutroCaso
        PRINT_STRING [EDX]
    LOOP3:
        
    xor eax, eax
    ret        
                        
    
    Caso1:
        mov EDX, msgC1
        ret
    Caso2:
        mov EDX, msgC2
        ret
    Caso3:
        mov EDX, msgC3
        ret    
    Caso4:
        mov EDX, msgC4
        ret    
    OutroCaso:
        mov EDX, msgOC
        ret