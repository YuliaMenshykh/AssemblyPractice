section .data

    promptMessage db "Enter a number: ", 0
    promptMessageLen equ $ - promptMessage

    loopMessage db "Factorial (Loop): ", 0
    loopMessageLen equ $ - loopMessage

    recursionMessage db "Factorial (Recursion): ", 0
    recursionMessageLen equ $ - recursionMessage

section .bss
    inputBuffer resb 4               ; Buffer for reading input 
    outputBuffer resb 20             ; Buffer for printing results (up to 20 digits)

section .text
    global _start

_start:
; Input Handling
; ---------------------------
; Display the prompt
    mov rax, 1                       
    mov rdi, 1                       
    mov rsi, promptMessage           
    mov rdx, promptMessageLen        
    syscall

; Read the input number
    mov rax, 0                       
    mov rdi, 0                       
    mov rsi, inputBuffer             
    mov rdx, 4                       
    syscall

; Convert input from ASCII to integer
    sub byte [inputBuffer], '0'      
    movzx rbx, byte [inputBuffer]    ; Move input to rbx

; Loop-based Factorial Calculation
; ---------------------------
    call factorialLoop               
    mov rbx, rax                     ; Store result in rbx

; Display loop-based result
    mov rax, 1                       
    mov rdi, 1                       
    mov rsi, loopMessage             
    mov rdx, loopMessageLen          
    syscall

; Convert and display loop result
    call printResult

; Tail-Recursive Factorial Calculation
; ---------------------------
    call factorialTailRecursive     

; Display recursion-based result
    mov rax, 1                       
    mov rdi, 1                       
    mov rsi, recursionMessage        
    mov rdx, recursionMessageLen     
    syscall

; Convert and display recursion result
    call printResult

; Exit the program
_exit:
    mov rax, 60                      
    xor rdi, rdi                     
    syscall

; Unrolled Loop-based Factorial Procedure
; ----------------------------------------
factorialLoop:
    mov rcx, rbx                     ; Initialize counter
    mov rax, 1                       ; Start with 1 
    test rcx, rcx                    ; Check if input is 0
    jz done

loop:
    imul rax, rcx                    ; rax = rax * rcx
    dec rcx                          
    test rcx, rcx                    
    jz done
    imul rax, rcx                    
    dec rcx                          
    jnz loop                         

done:
    ret

; Tail-Recursive Factorial Procedure
; ----------------------------------------
factorialTailRecursive:
    cmp rax, 1                       ; If n <= 1, return 1
    jle .baseCase
    push rbx                         ; Save current rbx (n)
    mov rcx, rax                     ; Move n to rcx
    dec rcx                          ; rcx = n - 1
    mov rax, 1                       ; Start with 1 for the multiplication
    call factorialTailRecursive      ; Recursively calculate factorial(n-1)
    imul rbx, rcx                    ; Multiply result by original n
    pop rbx                          
    ret

.baseCase:
    mov rax, 1                       ; Return 1 for base case
    ret

; Print Result
; ----------------------------------------
printResult:
    mov rax, rbx                     ; Move result from rbx to rax for division
    mov r8, 10                       
    lea rdi, [outputBuffer + 19]     ; Set rdi to the end of the buffer
    mov byte [rdi], 0xA              ; Newline 

.convert:
    xor rdx, rdx                     
    div r8                           
    add dl, '0'                      
    dec rdi                          ; Move buffer pointer backwards
    mov [rdi], dl                    ; Store digit in buffer
    test rax, rax                    
    jnz .convert                     

; Calculate the number of characters to print
    mov rax, outputBuffer + 20       
    sub rax, rdi                     ; number of characters
    mov rdx, rax                     

; Print the result
    mov rsi, rdi                    
    mov rax, 1                    
    mov rdi, 1
    syscall
    ret
