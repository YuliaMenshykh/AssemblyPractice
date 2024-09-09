section .data

    unsortedArray db 5, 3, 8, 6, 2
    arraySize equ 5

    fmt db 'Unsorted array: %s', 0xA, 0xD
    fmtSorted db 'Sorted array: %s', 0xA, 0xD
    fmtElement db '%d ', 0

section .bss
    buffer times arraySize resb '0'
    temp resb 1

section .text
    extern printf, sprintf, strlen, strcat
    global main

main:

    mov rdi, fmt
    mov rsi, buffer
    mov rdx, unsortedArray
    call arrayToString
    mov rsi, rax
    call printf

    mov rdi, unsortedArray
    mov rsi, buffer
    mov rcx, arraySize
    rep movsb

    mov rdi, buffer
    mov rsi, arraySize
    call bubbleSort

    mov rdi, fmtSorted
    mov rsi, buffer
    mov rdx, buffer
    call arrayToString
    mov rsi, rax
    call printf

    mov rax, 60
    xor rdi, rdi
    syscall

arrayToString:
    mov rbx, buffer
    mov byte [rbx], 0
    mov rcx, rsi
    mov rdi, rdx
.nextElement:
    mov al, [rdi]
    movzx rsi, al
    mov rdi, fmtElement
    call sprintf
    mov rbx, rax
    call strlen
    mov rdx, rax
    call strcat
    inc rdi
    dec rcx
    jnz .nextElement
    mov rax, buffer
    ret

bubbleSort:
    dec rsi
.outerLoop:
    mov rcx, rsi
    mov rbx, rdi
.innerLoop:
    mov al, [rbx]
    mov bl, [rbx+1]
    cmp al, bl
    jbe .noSwap

    mov [temp], al
    mov al, bl
    mov [rbx], al
    mov al, [temp]
    mov [rbx+1], al

.noSwap:
    inc rbx
    loop .innerLoop
    dec rsi
    jnz .outerLoop
    ret
