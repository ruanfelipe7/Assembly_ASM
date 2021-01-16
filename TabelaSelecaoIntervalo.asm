%include "io.inc"

section .data
    TabelaSelecao DD 1
    DD Caso1
    TamIntervalo EQU ($ - TabelaSelecao)
    TamIntervdosNumeros EQU 3
    DD 4
    DD Caso2
    DD 7
    DD Caso3
    DD 10
    DD Caso4
    NumerodeEntradas EQU ($ - TabelaSelecao) / TamIntervalo
    msgC1 DB "Caso de teste do numero 1,2,3", 0
    msgC2 DB "Caso de teste do numero 4,5,6", 0
    msgC3 DB "Caso de teste do numero 7,8,9", 0
    msgC4 DB "Caso de teste do numero 10,11,12", 0
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
        jne LOOPEXTRA
        VOLTA:
        call [EBX + 4]
        PRINT_STRING [EDX]
        jmp LOOP3
    LOOPEXTRA:
        push ECX
        push EDX
        mov ECX, TamIntervdosNumeros - 1
        mov EDX, [EBX]
        inc EDX
        LOOP4:
           cmp EAX, EDX 
           je FIMSEOCORRERIGUAL
           inc EDX
           loop LOOP4
       pop EDX
       pop ECX  
       jmp LOOP2 
       FIMSEOCORRERIGUAL:
       pop EDX
       pop ECX
       jmp VOLTA
        
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