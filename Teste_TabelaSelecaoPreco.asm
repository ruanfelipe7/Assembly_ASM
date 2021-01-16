%include "io.inc"

section .data
    TabelaSelecaoPreco DD 300                       ;Criação da Tabela com o primeiro valor
    DD Caso1                                        ;Criando as labels com os endereços das funções
    TamDadoComEndereco EQU ($ - TabelaSelecaoPreco) ;Determinando o tamanho do intervalo do dado junto com endereço da função
    DD 500                                          ;Continuação da Tabela
    DD Caso2
    DD 700
    DD Caso3
    DD 800
    DD Caso4
    DD 1000
    DD Caso5
    NumerodeEntradas EQU ($ - TabelaSelecaoPreco) / TamDadoComEndereco ;Calculando o numero de entradas na tabela
    msgC1 DB "50%", 0                                                  ;Criando as mensagens especificas de cada caso em uma determinada posição de memória
    msgC2 DB "40%", 0
    msgC3 DB "30%", 0
    msgC4 DB "20%", 0
    msgC5 DB "10%",0
    msgOC DB "5%",0                                                    ;A ultima mensagem será referente ao default do switch case
        

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_UDEC 4, EAX                          ;Recebendo o valor digitado pelo usuário em EAX
    mov EBX, TabelaSelecaoPreco              ;Move-se para EBX o endereço inicial da tabela       
    mov ECX, NumerodeEntradas                ;Move-se pra ECX a quantidade de casos da tabela
    
    LOOP1:
        cmp EAX, [EBX]                       ;Compara-se o valor recebido com cada valor definido na tabela   
        jnbe LOOP2                           ;Se o numero digitado não for menor ou igual ao valor da tabela, salte para o proximo caso
        call [EBX + 4]                       ;Se for menor ou igual chama a função que trata de cada caso da tabela, de acordo com o endereço da função guardado na tabela
        PRINT_STRING [EDX]                   ;Imprime o valor contido no endereço que EDX recebeu, ou seja, a porcentagem do caso que foi selecionado
        jmp LOOP3                            ;Pula para o final da execução (Break)
    LOOP2:                                   
        add EBX, TamDadoComEndereco          ;Adiciona no endereço contido em EBX o valor de TamDadoComEndereco para saltar e verificar as proximas posições da tabela  
        dec ECX                              ;Decrementa-se o valor de ECX
        jnz LOOP1                            ;Caso o ECX seja diferente de 0, significa que ainda há casos que ainda podem ser testados, portanto salte de volta para loop1 para verificar os proximos casos da tabela
        call OutroCaso                       ;Se ECX for igual a 0, chama a função que trata do caso default   
        PRINT_STRING [EDX]                   ;Imprime o valor contido no endereço que EDX recebeu, ou seja, a porcentagem do caso default 
    LOOP3:
        
    xor eax, eax
    ret        
                        
    ;---------------------------------------------------------------------------------
    Caso1:
        ;Returns: retorna em EDX o endereço onde a mensagem está armazenada na memória
        mov EDX, msgC1
        ret
    ;---------------------------------------------------------------------------------    
    Caso2:
        ;Returns: retorna em EDX o endereço onde a mensagem está armazenada na memória
        mov EDX, msgC2
        ret
    ;---------------------------------------------------------------------------------    
    Caso3:
        ;Returns: retorna em EDX o endereço onde a mensagem está armazenada na memória
        mov EDX, msgC3
        ret
    ;---------------------------------------------------------------------------------        
    Caso4:
        ;Returns: retorna em EDX o endereço onde a mensagem está armazenada na memória
        mov EDX, msgC4
        ret
    ;---------------------------------------------------------------------------------    
    Caso5:
        ;Returns: retorna em EDX o endereço onde a mensagem está armazenada na memória
        mov EDX, msgC5
        ret
    ;---------------------------------------------------------------------------------               
    OutroCaso:
        ;Returns: retorna em EDX o endereço onde a mensagem está armazenada na memória
        mov EDX, msgOC
        ret
    ;---------------------------------------------------------------------------------    