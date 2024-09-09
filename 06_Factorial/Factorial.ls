     1                                  section .data
     2 00000000 05                          inputValue db 5                   ; Input value for factorial
     3 00000001 54686520666163746F-         fmt db "The factorial is: %d", 0xA, 0  ; Format string for printf
     3 0000000A 7269616C2069733A20-
     3 00000013 25640A00           
     4                                  
     5 00000017 456E74657220612070-     	inputMsg db "Enter a positive integer: ", 0
     5 00000020 6F7369746976652069-
     5 00000029 6E74656765723A2000 
     6                                      inputLen equ $ - inputMsg
     7                                      
     8                                      
     9                                  section .bss
    10 00000000 ????????????????            result resb 8                     ; Reserve space for the result
    11                                  
    12                                  section .text
    13                                      global main
    14                                      extern printf                      ; Declare the C printf function
    15                                  
    16                                  main:
    17                                  
    18                                      ; Initialize
    19 00000000 480FB60425-                 movzx rax, byte [inputValue]       ; Load input value (5 in this case)
    19 00000005 [00000000]         
    20 00000009 4889C3                      mov rbx, rax                       ; Store input in rbx (for loop)
    21 0000000C B901000000                  mov rcx, 1                         ; Initialize factorial result to 1
    22                                  
    23                                  findFactorial:
    24 00000011 4883FB01                    cmp rbx, 1                         ; Compare rbx with 1
    25 00000015 7E09                        jle end                            ; Exit loop if rbx <= 1
    26 00000017 480FAFCB                    imul rcx, rbx                      ; rcx = rcx * rbx (factorial computation)
    27 0000001B 48FFCB                      dec rbx                            ; rbx = rbx - 1
    28 0000001E EBF1                        jmp findFactorial                  ; Repeat the loop
    29                                  
    30                                  end:
    31                                      ; At this point, rcx contains the factorial result
    32                                  
    33                                      ; Call printf to print the result
    34 00000020 48BF-                       mov rdi, fmt                       ; First argument: address of format string
    34 00000022 [0100000000000000] 
    35 0000002A 4889CE                      mov rsi, rcx                       ; Second argument: the factorial result (in rcx)
    36 0000002D 4831C0                      xor rax, rax                       ; Clear rax (required for variadic functions)
    37 00000030 E8(00000000)                call printf                        ; Call the printf function
    38                                  
    39                                      ; Exit
    40 00000035 B83C000000                  mov rax, 60                        ; sys_exit system call
    41 0000003A 4831FF                      xor rdi, rdi                       ; Exit code 0
    42 0000003D 0F05                        syscall                            ; Invoke the system call
