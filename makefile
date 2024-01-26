all: c asm
c:
	gcc -c a.c -o a.o
	gcc    a.o -o c.out

asm:
	as a.s    -o a.step
	ld a.step -o asm.out

debug:
	gcc  a.s -o asm_d.out -nostdlib -g -no-pie
	gdb asm_d.out

check: | c
	objdump c.out --disassemble=main 

clean:
	rm *.out a.o a.step
