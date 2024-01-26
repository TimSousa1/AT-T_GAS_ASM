.globl _start

.section .data
# message for printing
msg: .ascii "awesome!\n"
len = . - msg

# number to increment memory directly
x: .int 79

# syscalls
sys_write: .int 1
sys_exit: .int 60

.text
_start:
    # adding two numbers
    mov    $1, %eax
    mov    $2, %ebx
    add    %ebx, %eax

    # printing a string
    mov    $sys_write, %rax
    mov    $1, %rdi     # to stdout
    mov    $msg, %rsi   # char *buf
    mov    $len, %rdx   # strlen
    syscall

    # loop 5 times
    mov    $0, %r8d
    mov    $5, %r9d
loop:
     
    # sys_write replaces whatever was on %rax
    # %rax value has to be reset for every call
    mov    $sys_write, %rax
    syscall

    add    $1, %r8d
    cmp    %r9d, %r8d
    jge    next

    jmp    loop

next:
    # adding with a number from memory
    # (x) peeks into x's address and changes the value stored there
    addl    $10, (x)
    mov     (x), %r9d    # easier to check the value when debugging
    
exit:
    # exiting
    mov    $sys_exit, %rax
    add    $0, %rdi          # exit code 0
    syscall
