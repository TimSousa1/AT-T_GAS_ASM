.text

.globl _start
_start:
    mov $1, %eax
    mov $2, %ebx
    add %ebx, %eax

    mov $60, %rax
    add $0, %rdi
    syscall
