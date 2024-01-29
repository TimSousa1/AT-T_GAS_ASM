.globl _start

.data
# string
msg: .ascii "Doing something!\n"
len = . - msg
# syscalls
sys_exit:  .quad 60
sys_write: .quad  1

.text
_start:
    call   do_something

    mov    $len,%r8
    mov    sys_write,%r9
    mov    sys_exit,%r10

    mov    sys_exit,%rax
    mov    $0,%rdi           # exit code
    syscall

do_something:
    mov    sys_write, %rax
    mov    $1, %rdi          # stdout
    mov    $msg, %rsi
    mov    $len, %rdx
    syscall

    ret
