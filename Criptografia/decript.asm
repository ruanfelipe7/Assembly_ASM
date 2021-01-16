
%define BUF_SIZE 1
extern printf

section .data
msg_error DB "Erro ao ler o arquivo",0xA, 0
msg_error2 DB "Erro ao criar o arquivo", 0xA, 0

section .bss
fd_in resd 1
fd_out resd 1
in_buf resd BUF_SIZE
name_arquivo RESB 105
new_name RESB 100
key resb 1

section .text
global decrIptar
decrIptar:

    
    mov EDX, [ESP+4] ;passando a key para EDX
    mov EAX, [ESP+8] ;passando o nome do arquivo

    mov BYTE [key], DL ;passando a chave para a memoria

    ;passando o nome para o name_arquivo e new_name
    mov ESI, 0      ;zerando o indice
    mov EDI, 0      ;zerando o indice
    mov ECX, 26     ;movendo o valor do contador
    mov DL, 0
    
    Get_name:
    
    mov BL, [EAX+ESI]                   ;movendo o byte do nome do arquivo correspondente para BL
    mov DL, [EAX+EDI]                   ;movendo o byte do nome do arquivo correspondente para DL
    mov BYTE [name_arquivo+ESI], BL     ;movendo esse byte para name_arquivo
    cmp BL, '.'                         ;comparação se BL chegou ao ponto
    jne Cont                            ;se não eh feito um salto para continuar a cópia do nome
    mov DL, BL                          ;caso seja um ponto, DL recebe esse ponto
    sub EDI, 4             ;subtra-se 4 de EDI, para que esse '.' seja colocado no lugar do '_'
    mov ECX, 4
    Cont:
    mov BYTE [new_name+EDI], DL     ;movendo o byte para o nome do novo arquivo que vai ser criado
    inc ESI                         ;incrementa-se os indices 
    inc EDI
    loop Get_name

    mov AL, 't'             ;move-se o 't' de crpt da extensao do arquivo criptografado para AL
    mov BYTE [name_arquivo+ESI], AL ;de AL esse 't' será colocado no nome do arquivo

    ;abrir o aqruivo para ler seu conteúdo
    mov EAX,5               ;abrir o arquivo
    mov EBX, name_arquivo   ;ponteiro para o nome do arquivo
    mov ECX,0               ;bits de acesso
    mov EDX,0700            ;permissões do arquivo
    int 0x80                ;interrupção
    mov [fd_in],EAX         
    
    ;verificação se houve erro ao abrir o arquivo
    cmp EAX,0
    jge create_file
    push msg_error
    call printf               ;imprimindo a mensagem se ocorreu erro  
    add ESP, 4
    jmp erro1                 ;pula-se para o final
    
    create_file:
    ;criando arquivo criptografado
    mov EAX,8                ;criar o arquivo
    mov EBX, new_name        ;ponteiro para o nome do novo arquivo criptografado
    mov ECX,0777             ;permissões
    int 0x80
    mov [fd_out],EAX
    
    ;verificação se houve erro ao criar o arquivo
    cmp EAX,0             
    jge repeat_read
    push msg_error2
    call printf               ;imprimindo a mensagem se ocorreu um erro 
    add ESP, 4
    jmp erro2                 ;pula-se para o final

repeat_read:
; leitura do arquivo
    mov EAX,3             ;ler do arquivo
    mov EBX, [fd_in]      ;descritor do arquivo
    mov ECX, in_buf       ;buffer
    mov EDX, BUF_SIZE     ;tamanho a ser lido
    int 0x80              ;interrupção

 ;decriptografia
    push EAX
    mov AL, [in_buf]
    mov DL, [key]
    ROL AL, 5            ;shift rotativo a esquerda 5 vezes
    XOR AL, DL
    sub AL, DL
    mov BYTE [in_buf], AL
    pop EAX
 ;escrita no novo arquivo ja com o dado criptografado
    mov EDX,EAX           
    mov EAX,4             ;escrever no arquivo
    mov EBX,[fd_out]      ;descritor do arquivo
    mov ECX,in_buf        ;buffer
    int 0x80              ;interrupção
    
    cmp EDX,BUF_SIZE      ;compara-se EDX (bytes lidos) com o tamanho buffer
    jl FimCopia           ;se EDX for menor que o tamanho do buffer significa que acabou o conteudo do arquivo
    jmp repeat_read       ;se não continue lendo e criptografando
    
FimCopia:
    mov EAX,6             ;fecha-se o arquivo que foi criado com a criptografia
    mov EBX,[fd_out]
    int 0x80

;fechando arquivo de input
    mov EAX,6             ;fecha-se o arquivo de onde foi lido o conteúdo
    mov EBX,[fd_in]
    int 0x80

    xor eax, eax          ;zera-se EAX, significando que a criptografia foi concluída
    ret 

erro1:
    mov EAX, 1            ;move-se para EAX o valor 1 significando que ocorreu um erro
    ret 
erro2:
    mov EAX,6             ;fecha-se o arquivo de onde ia ser lido o conteudo
    mov EBX,[fd_in]
    int 0x80 
    mov EAX, 1            ;move-se para EAX o valor 1 significando que ocorreu um erro  
    ret 