section .data

    promptMessage db "Enter a number: ", 0
    promptMessageLen equ $ - promptMessage

    loopMessage db "Factorial (Loop): ", 0
    loopMessageLen equ $ - loopMessage

    recursionMessage db "Factorial (Recursion): ", 0
    recursionMessageLen equ $ - recursionMessage

section .bss

    inputNumber resb 4               ; buffer for input number
    resultLoop resq 1                ; loop factorial result
    resultRecursion resq 1           ; recursion factorial result
    inputBuffer resb 4               ; reading input
    outputBuffer resb 20             ; printing results (20 digits)

section .text
    global _start

_start:
    
; Input Handling
; ---------------------------
;write input prompt
    mov rax, 1                       
    mov rdi, 1                      
    mov rsi, promptMessage           
    mov rdx, promptMessageLen        
    syscall

;read the input number
    mov rax, 0            
    mov rdi, 0            
    mov rsi, inputBuffer  
    mov rdx, 4            
    syscall

;from ASCII to integer
    sub byte [inputBuffer], '0'      
    movzx rbx, byte [inputBuffer]    ; Move input to rbx

;check if input is valid
    cmp rbx, 0
    jle _exit

;store the input in inputNumber
    mov [inputNumber], rbx


;Loop-based Factorial 
; ---------------------------
    mov rax, rbx                     
    call factoriaLoop              
    mov [resultLoop], rax            

;print Loop-based result
    mov rax, 1                       
    mov rdi, 1                       
    mov rsi, loopMessage             
    mov rdx, loopMessageLen          
    syscall

    mov rax, [resultLoop]
    call printResult


;Recursive Factorial Calculation
; ---------------------------
    mov rax, rbx                    
    call factorialRecursion        
    mov [resultRecursion], rax      

;display recursion result
    mov rax, 1                       
    mov rdi, 1                       
    mov rsi, recursionMessage        
    mov rdx, recursionMessageLen     
    syscall

;print recursion result
    mov rax, [resultRecursion]
    call printResult

; Exit
_exit:
    mov rax, 60      
    xor rdi, rdi     
    syscall


; Loop-based Factorial 
; -----------------------------------
factoriaLoop:
    mov rcx, rax                     ; initialize counter
    mov rax, 1                       
loop:
    cmp rcx, 1                       
    jle end
    imul rax, rcx                    ; rax = rax * rcx
    dec rcx                          ; decrement counter
    jmp loop
end:
    ret


; Recursive Factorial Procedure
; ----------------------------------------
factorialRecursion:
    cmp rax, 1                       
    jle out
    push rax                         ; Save current rax (n)
    dec rax                          ; n = n - 1
    call factorialRecursion         ; Recursively calculate factorial(n-1)
    pop rbx                          ; Restore original rax (n)
    imul rax, rbx                    ; Multiply rax by n
    ret
out:
    mov rax, 1                       ; Return 1 for base case
    ret


; Print Result
; ----------------------------------------
printResult:

    push rax                        
    mov r8, 10						; base 10 divisor
    xor rcx, rcx                     
    lea rdi, [outputBuffer + 19]	; set rdi to the end of the buffer
    mov byte [rdi], 0xA             ; newline 

convert:
    xor rdx, rdx                    
    div r8                          ; Divide rax by 10
    add dl, '0'                     
    dec rdi                         ; Move buffer pointer backwards
    mov [rdi], dl                   ; Store digit in buffer
    inc rcx                         
    test rax, rax                 
    jnz convert

    pop rax                          

; Print the result from rdi
    mov rsi, rdi                     ; Pointer to buffer start
    mov rdx, 20                      ; Max 20 characters + newline
    mov rax, 1                       
    mov rdi, 1                      
    syscall
    ret
