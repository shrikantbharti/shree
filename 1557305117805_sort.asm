;Name : Shrikant Bharti
;R_no : 203702
;div : 7 G1 SYBtech CSE

section .data
msg db "SORTING PROGRAM",10
msg_len equ $-msg

msg1 db "NUMBERS ARE : ",10
msg1_len equ $-msg1

msg2 db "SORTED ARRAY IS : ",10
msg2_len equ $-msg2

arr db 10h,30h,20h,50h,0Ah

section .bss
result resb 20

%macro rw 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
syscall
%endmacro

section .text
global _start
_start:

arraycnt:
mov bl,5    ;Array of 5

out_loop:
	mov cl,4
	mov rsi,arr

up:
	mov al,byte[rsi]
	cmp al,byte[rsi+1]   ;byte[rsi]=byte[rsi+1]
	jbe loop_inc			;if jbe go for increment 
	
	xchg al,byte[rsi+1]
	mov byte [rsi],al

loop_inc:
	inc rsi
	dec cl
	jnz up
	dec bl
jnz out_loop			;jnz go to outer loop

	mov rdi,arr
	mov rsi,result
	mov dl,10

displayLoop1:
	mov cl,2
	mov al,[rdi]

again:
	rol al,4
	mov bl,al
	and al,0Fh
	cmp al,09h
jbe down
	add al,07h
	
down:
	add al,30h
	mov byte[rsi],al
	mov al,bl
	inc rsi
	dec cl
jnz again

	mov byte[rsi],0AH
	inc rsi
	inc rdi
	dec dl
	
jnz displayLoop1
rw 1,1,result,15

rw 60,0,0,0


;output:c04l0514@c04l0514:~$ nasm -f elf64 sort.asm
c04l0514@c04l0514:~$ ld -o sort sort.o
c04l0514@c04l0514:~$ ./sort
0A
10
20
30
50

