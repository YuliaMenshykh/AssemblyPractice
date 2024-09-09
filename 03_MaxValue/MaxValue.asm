section	.data
   
	firstValue dd '11'
	secondValue dd '55'
	thirdValue dd '3'
   
	resultMSG db "The largest digit is: ", 0xA,0xD 
	length equ $- msg 
   
segment .bss
	largest resb 2  

section	.text
   global _start  
_start:	   
          
;compare first and second value   
	mov   rcx, [firstValue]
	cmp   rcx, [secondValue]
	jg    checkLast
	mov   rcx, [secondValue]
;compare with last one 
checkLast:
	cmp   rcx, [thirdValue]
	jg    exit
	mov   rcx, [thirdValue]
   
exit:
	mov   [largest], rcx
;print result 
	mov   rcx,resultMSG
	mov   rdx, length
	mov   rbx,1	
	mov   rax,4	
	int   0x80	

	mov   rcx,largest
	mov   rdx, 2
	mov   rbx,1
	mov   rax,4	
	int   0x80	
	
;exit   
	mov   rax, 1
	int   80h
