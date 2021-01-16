%include "io.inc"

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    mov ECX, 0
    
    ;Recebendo os valores e a operação 
    GET_UDEC 4, EAX
    GET_CHAR CL
    GET_UDEC 4, EBX
    
    ;Switch da operação
    mov dl, '+'
    sub dl, cl
    jz callsoma
    
    mov dl, '-'
    sub dl, cl
    jz callsub
    
    mov dl, '*'
    sub dl, cl
    jz callmult 
    
    mov dl, '/'
    sub dl, cl
    jz calldiv
    
    ;etiquetas que chamam as funções para executar as operações
    callsoma:
        PRINT_UDEC 4, EAX
        PRINT_STRING " + "
        PRINT_UDEC 4, EBX
        PRINT_STRING " = "
        call Soma
        PRINT_UDEC 4, EAX
        NEWLINE
        jmp FINAL
    
    callsub:
        PRINT_UDEC 4, EAX
        PRINT_STRING " "
        PRINT_CHAR CL
        PRINT_STRING " "
        PRINT_UDEC 4, EBX
        PRINT_STRING " = "
        call Subtracao
        PRINT_UDEC 4, EAX
        NEWLINE
        jmp FINAL
                 
   callmult:
        PRINT_UDEC 4, EAX
        PRINT_STRING " * "
        PRINT_UDEC 4, EBX
        PRINT_STRING " = "
        call Multiplicacao
        PRINT_UDEC 4, EAX
        NEWLINE
        jmp FINAL
        
    
    calldiv:
        PRINT_UDEC 4, EAX
        PRINT_STRING " / "
        PRINT_UDEC 4, EBX
        PRINT_STRING " = "
        call Divisao
        PRINT_UDEC 4, EAX
        NEWLINE
        jmp FINAL
        
    FINAL:
    
    xor eax, eax
    ret

;---------------------------------        
Soma:  
  add EAX, EBX
  ret
;---------------------------------

;---------------------------------
Subtracao:
    sub EAX, EBX
    ret
;---------------------------------

;---------------------------------
Multiplicacao:
    push ECX
    mov ECX, EBX
    mov EBX, EAX
    mov EAX, 0
    .L1:
        call Soma
        loop .L1
    pop ECX
    ret      
;---------------------------------

;---------------------------------
Divisao:
    push EDX
    mov EDX, 0
    .DIVIDINDO:
        call Subtracao
        js FIM_DIVISAO
        inc EDX
        jmp .DIVIDINDO
        FIM_DIVISAO: 
        mov EAX, EDX
        pop EDX
        ret 
;---------------------------------