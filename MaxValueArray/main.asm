
segment .data

	msg db "The largest digit is: ", 0xA,0xD 
	len equ $- msg 

section	.text
   global _start     
_start: 

   ; print the message
    mov eax, 4            ; sys_write
    mov ebx, 1            ; file descriptor (stdout)
    mov ecx, msg          ; message to write
    mov edx, len          ; length of message
    int 0x80              ; call kernel

    ; exit
    mov eax, 1            ; sys_exit
    xor ebx, ebx          ; exit code 0
    int 0x80              ; call kernel




