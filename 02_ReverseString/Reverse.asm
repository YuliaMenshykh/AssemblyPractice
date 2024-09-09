section .data

    originalStr db 'Hello', '0'   
    strLength equ $ - originalStr -1   
    
section .bss

    reversedStr times strLength resb '0'

section .text
    global _start

_start:

    lea rsi, [originalStr] ;start of originalStr
    lea rdi, [reversedStr] ;start of reversedStr
    mov rcx, strLength              
    
    add rsi, rcx                   
	dec rsi
	
reverseLoop:
    mov al, [rsi]  ; Load from originalStr into AL
    mov [rdi], al                  
    dec rsi                        
    inc rdi                        
    loop reverseLoop              

    ;nill-terminate reversedStr
    mov byte [rdi], '0'              
               

;print the reversed string
    mov rax, 4           
    mov rbx, 1            
    mov rcx, reversedStr
    mov rdx, strLength       
    int 0x80          

;exit
    mov rax, 1 
    xor rbx, rbx 
    int 0x80      

