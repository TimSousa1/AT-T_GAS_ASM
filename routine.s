.globl _start

.data
# string
msg: .ascii "Doing something!\n"
len = . - msg
# syscalls
sys_exit:  .int 60
sys_write: .int  1

.text
_start:
    call   do_something

    mov    $len,%r8
    mov    sys_write,%r9d
    mov    sys_exit,%r10d

    mov    sys_exit,%eax
    mov    $0,%rdi           # exit code
    syscall

do_something:
    mov    sys_write, %eax
    mov    $1, %rdi          # stdout
    mov    $msg, %rsi
    mov    $len, %rdx
    syscall

    ret
