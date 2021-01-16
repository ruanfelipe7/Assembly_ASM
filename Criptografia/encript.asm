
%define BUF_SIZE 1
extern printf
section .data
msg_error DB "Erro ao ler o arquivo",0xA, 0
msg_error2 DB "Erro ao criar o arquivo", 0xA, 0
nova_extensao DB "crpt", 0xA, 0

section .bss

fd_in resd 1
fd_out resd 1
in_buf resd BUF_SIZE
name_arquivo RESB 100
new_name RESB 105
key resb 1

section .text
global encrIptar
encrIptar:

    
    mov EDX, [ESP+4] ;passando a key para EDX
    mov EAX, [ESP+8] ;passando o nome do arquivo

    mov BYTE [key], DL ;passando a chave para a memoria

    ;passando o nome para o name_arquivo e new_name
    mov ESI, 0 ;zerando o indice
    mov ECX, 25 ;movendo o valor do contador
    mov DL, 0
    
    Get_name:
    
    mov BL, [EAX+ESI]          ;movendo o byte do nome do arquivo correspondente para BL
    mov [name_arquivo+ESI], BL ;movendo esse byte para name_arquivo
    cmp BL, '.'                ;comparação se BL chegou ao ponto
    jne Cont                   ;se não eh feito um salto para continuar a passagem de valores
    mov DL, BL                 ;caso seja um ponto, DL recebe esse ponto
    mov BL, '_'                ;BL recebe entao o '_' 
    mov ECX, 4                 
    Cont:
    mov [new_name+ESI], BL  ;movendo o byte para o nome do novo arquivo que vai ser criado
    inc ESI                 ;incrementa se o indice         
    loop Get_name              
    
    ;complementando com a nova extensao crpt      
    mov BYTE [new_name+ESI], '.'
    mov EDX, [nova_extensao]
    add ESI, 1
    mov DWORD [new_name+ESI], EDX
    
    ;abrir o aqruivo para ler seu conteúdo
    mov EAX,5               ;abrir o arquivo
    mov EBX, name_arquivo   ;ponteiro para o nome do arquivo
    mov ECX, 0              ;bits de acesso
    mov EDX, 0700           ;permissões do arquivo
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
    mov ECX, 0777            ;permissões
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

 ;criptografia
    push EAX
    mov AL, [in_buf]
    mov DL, [key]
    add AL, DL
    XOR AL, DL
    ROR AL, 5             ;shift rotativo a direita 5 vezes
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