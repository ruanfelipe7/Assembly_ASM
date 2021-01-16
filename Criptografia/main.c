#include <stdio.h>
#include <string.h>

int encrIptar(char key, char name[101]);
int decrIptar(char key, char name[105]);

int main(int argc, char const *argv[])
{	
	int option = 0;
	char chave;	
	char nome[105];
	printf("Digite 0 para criptografar e 1 para descriptografar\n");
	scanf(" %d", &option);	
	printf("Digite a key\n");
	scanf(" %c", &chave);
	printf("Digite o nome do arquivo\n");
	scanf(" %[^\n]s", nome);
	
	//envie 0 para criptografar e 1 para descriptografar
	if(!option){
		if(encrIptar(chave, nome))
			printf("Erro ao criptografar\n");  //retorno 1 ocorreu erro
		else
			printf("Criptografia concluida\n"); //retorno 0 operação concluida
	}else if(option == 1){
		if(decrIptar(chave, nome))
			printf("Erro ao descriptografar\n");
		else
			printf("Descriptografia concluida\n");
		
	}else{
		printf("Digito de opcao invalido\n");
	}	
	
	return 0;
	
}