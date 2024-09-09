section .data
   
	wordArray dw 2, 5, 1, 4, 8, 9, 1
	.TYPE equ 2
	.SIZEOF equ $-wordArray

	msg db "The largest digit is: ", 0xA,0xD 
	len equ $-msg 
	
section .bss
	largest resb 2  

section .text
	global _start       

_start:	              
    mov rcx, 7 / 4      ;4 elements per iteration
    mov rsi, wordArray  
	xor rax, rax        
	
	call findMaxValue
	
;handle remainings
	mov rcx, 7 % 4
	jz done             
	call findMaxRemaining

done:
;convert the largest value to a string
    mov [largest], rax    
    mov rax, [largest]
    add rax, '0'       
    mov [largest], rax

; Print the message
    mov rax, 4           
    mov rbx, 1           
    mov rcx, msg    
    mov rdx, len          
    int 0x80            

; Print the largest digit
    mov rax, 4           
    mov rbx, 1            
    mov rcx, largest      
    mov rdx, 1           
    int 0x80             

; Exit
    mov rax, 1           
    xor rbx, rbx         
    int 0x80             



findMaxValue:
;compare four elements at once
compareLoop:
    movzx rbx, word [rsi]     
    movzx rdx, word [rsi + 2] 
    movzx r8, word [rsi + 4]  
    movzx r9, word [rsi + 6]  

;store maximum value in rax
    cmp rax, rbx
    cmovl rax, rbx ;rax = rbx if rax < rbx

    cmp rax, rdx
    cmovl rax, rdx

    cmp rax, r8
    cmovl rax, r8

    cmp rax, r9
    cmovl rax, r9

;move to the next 4 elements
    add rsi, 8
    loop compareLoop
    ret


findMaxRemaining:

;if less than 4
compareRemaining:
    movzx rbx, word [rsi]
    cmp rax, rbx
    cmovl rax, rbx

    add rsi, 2
    loop compareRemaining
    ret
