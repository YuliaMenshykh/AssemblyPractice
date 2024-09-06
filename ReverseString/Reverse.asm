section .data

    originalStr db 'Hello',0
    strLength equ $ - originalStr
    reversedStr times strLength db 0
	
section .bss
	;reversedStr times strLength resb 0
section	.text
   global _start     
_start: 

	mov esi, originalStr
    mov edi, reversedStr
    mov ecx, strLength
    
loop:
	mov edi, [esi + ecx]
	dec ecx
	cmp ecx, 0
	jle write
  
    
write:
	mov edi, 0
    mov eax,4 ;sys write
    mov ebx, 1 ;file descriptor
    mov edx, strLength
    lea ecx, [reversedStr]
    int 0x80 
    
    mov eax, 1 
    xor ebx,ebx
    int 0x80
    
;nasm -f elf64 -o ReverseString.o Reverse.asm
;ld  ReverseString.o -o Reverse
;./Reverse
