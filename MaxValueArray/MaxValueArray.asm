section	.data
   
	wordArray dw 2,5,1,4,8,9,1
        .TYPE equ 2
        .SIZEOF equ $-wordArray
        .LENGTHOF equ wordArray.SIZEOF/wordArray.TYPE
	msg db "The largest digit is: ", 0xA,0xD 
	len equ $- msg 
segment .bss
	largest resb 2  

section	.text
	global _start       

_start:	              
  
    mov ecx, 8 ;counter for tje loop
    mov eax, [wordArray] ; store temporary result
    mov esi, wordArray ;the adress of the array
	xor edi, edi ; index register
 
	call maxValue
	
maxValue:
	movzx ebx, Word wordArray[edi*wordArray.TYPE]
	cmp eax,ebx
	jge maxLoop
	inc edi
	loop maxValue 
		
maxLoop:
	mov eax,ebx	
	inc edi
	loop maxValue ;if not greater
    
    
  ; convert the largest value to a string
    mov [largest], eax    ; store the largest value
    mov eax, [largest]
    add eax, '0'          ; convert the integer to ASCII (for digits 0-9)
    mov [largest], eax

    ; print the message
    mov eax, 4            ; sys_write
    mov ebx, 1            ; file descriptor (stdout)
    mov ecx, msg          ; message to write
    mov edx, len          ; length of message
    int 0x80              ; call kernel

    ; print the largest digit
    mov eax, 4            ; sys_write
    mov ebx, 1            ; file descriptor (stdout)
    mov ecx, largest      ; address of the largest digit string
    mov edx, 1            ; length of the largest digit
    int 0x80              ; call kernel

    ; exit
    mov eax, 1            ; sys_exit
    xor ebx, ebx          ; exit code 0
    int 0x80              ; call kernel




