section .data

    firstVal dd 1
    secondVal dd 6
    thirdVal dd 8
    
	resultText db "Result is: ",0xA,0xD
	resTextLength equ $ - resultText

section .bss

	result resd 1

section .text 
	global _start
_start:
;add 3 values
	mov eax,[firstVal]
	add eax,[secondVal]
	add eax,[thirdVal]
	add eax, '0' ;convert to string

	mov [result], eax

;print to the console
	mov ecx, resultText
	mov edx, resTextLength
	mov ebx, 1 
	mov eax,4 
	int 0x80 
;print the result
	mov ecx, result
	mov edx,1
	mov ebx,1
	mov eax,4
	int 0x80 
; exit 
	mov eax,1 
	int 0x80 





