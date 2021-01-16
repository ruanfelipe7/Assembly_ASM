section .data
	vet DD 10, 20, 30

section .bss
	resultado RESD 1000000
	
section .text

global Addvetor

Addvetor:
	mov ECX, 1000000
	mov EDX, [ESP+4]
	mov EBX, [ESP+8]
	mov ESI, 0
	Repete:
		mov EAX, [EDX+ESI]
		add EAX, [EBX+ESI]
		mov DWORD [resultado+ESI], EAX
		add ESI, 4
	loop Repete

	mov EAX, resultado
	ret 