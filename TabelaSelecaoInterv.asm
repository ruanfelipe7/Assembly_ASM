%include "io.inc"

section .data
    TabelaSelecao DD 1
    DD Caso1
    TamIntervalo EQU ($ - TabelaSelecao)
    DD 9
    DD Caso2
    DD 25
    DD Caso3
    DD 50
    DD Caso4
    NumerodeEntradas EQU ($ - TabelaSelecao) / TamIntervalo
    DD 80

    
    msgC1 DB "Caso de teste do numero 1 a 9", 0
    msgC2 DB "Caso de teste do numero 10 a 25", 0
    msgC3 DB "Caso de teste do numero 25 a 50", 0
    msgC4 DB "Caso de teste do numero 51 a 80", 0
    msgOC DB "Caso Indefinido",0
        
    Interv EQU 3
section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_UDEC 4, EAX
    mov EBX, TabelaSelecao
    mov ECX, NumerodeEntradas
   
    LOOP1:
        mov EDI, [EBX+8]
        sub EDI, [EBX]
        cmp EAX, [EBX]
        jb LOOP2
        mov EDX, [EBX]
        add EDX, EDI
        cmp EAX, EDX
        ja LOOP2
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