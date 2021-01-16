section .data
	vet DD 10, 20, 30

section .bss
	resultado RESD 1000000
	
section .text

global AddvetorMMX

AddvetorMMX:
	mov ECX, 500000
	mov EDX, [ESP+4]
	mov EBX, [ESP+8]
	mov ESI, 0
	Repete:
		movq MM0, QWORD [EDX+ESI]
		paddd MM0, [EBX+ESI]
		movq QWORD [resultado+ESI], MM0
		add ESI, 8
	loop Repete

	mov EAX, resultado
	ret 