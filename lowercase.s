.globl _start

.data
# string
msg: .ascii "ThIs Is sOme MessED up TExt!\n"
len = . - msg
# syscalls
sys_exit:  .int 60
sys_write: .int  1

.text
_start:
    # dummy values to check if 
    # they're properly saved
    mov    $1,%r8
    mov    $2,%r9
    mov    $3,%r10

    mov    $msg,%rdi
    mov    $len,%rsi
    call   lowercase
    
    # printing new string
    mov    %rax,%rsi
    mov    sys_write,%eax
    mov    $0,%rdi
    mov    $len,%rdx
    syscall

    # exit sequence
    mov    sys_exit,%eax
    mov    $0,%rdi           # exit code
    syscall

# char *lowercase(char *str, int len)
# rdi = *msg
# rsi = len
lowercase:
    # saving non-callee saved registers
    push   %r8
    push   %r9
    push   %r10
    
    # start
    xor    %r8,%r8           # i = 0
    mov    %rdi,%r9          # char *tmp = msg
main_loop:
    cmp    %rsi,%r8          # while i(r8) < len(rsi)
    jge    end

    movb   (%r9),%r10b       # get char from str (%r9 could be used directly)

    cmp    $65,%r10b         # skip if 'z' < *tmp < 'a'
    jl     skip
    cmp    $90,%r10b
    jg     skip

    add    $32,%r10b         # turn lowercase
    mov    %r10b,(%r9)       # store back in tmp

skip:
    add    $1,%r9            # tmp++ (point to next char)
    add    $1,%r8            # i++
    jmp    main_loop

end:
    # getting registers back
    pop    %r10
    pop    %r9
    pop    %r8
    # return value
    mov    %rdi,%rax
    ret
