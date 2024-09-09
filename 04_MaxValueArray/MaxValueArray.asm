section	.data
   
	wordArray dw 2,5,1,4,8,9,1
        .TYPE equ 2
        .SIZEOF equ $-wordArray
	msg db "The largest digit is: ", 0xA,0xD 
	len equ $- msg 
	
segment .bss
	largest resb 2  

section	.text
	global _start       

_start:	              
  
    mov rcx, 7 ;counter for tje loop
    mov rsi, [wordArray] ;store an adress of the array
	xor rdi, rdi ; index 
	xor rax, rax
	call findMaxValue
	sub rcx,1
	
findMaxValue:
	movzx rbx, Word wordArray[rdi*wordArray.TYPE]
	cmp rax,rbx
	jge notMax
	mov rax,rbx	
		
notMax:
	inc rdi
	loop findMaxValue ;if not greater
    
    
; convert the largest value to a string
    mov [largest], rax    
    mov rax, [largest]
    add rax, '0'          ; convert to ASCII (for digits 0-9)
    mov [largest], rax

; print the message
    mov rax, 4            
    mov rbx, 1            
    mov rcx, msg          
    mov rdx, len          
    int 0x80              

; print the largest digit
    mov rax, 4            
    mov rbx, 1            
    mov rcx, largest      
    mov rdx, 1            
    int 0x80              

; exit
    mov rax, 1            
    xor rbx, rbx          
    int 0x80              
