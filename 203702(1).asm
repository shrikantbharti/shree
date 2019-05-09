;Name : Shrikant Bharti
;class : SY Btech CSE 
;Div : G(1)

%macro operate 4
	mov rax,%1
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

section .data

msg11 db "Error !" ,10
msg11len equ $-msg11
msg12 db "Copy file successful" ,10
msg12len equ $-msg12

section .bss

fname1 resb 15
fd1 resq 1
fname2 resb 15
fd2 resq 1
buff resb 512
bufflen resq 1

section .text
global _start 
_start: 
pop r8
cmp r8,3
jne err
pop r8
pop r8
mov esi, fname1

above:

mov al,[r8]
cmp al,00
je next
mov [esi],al
inc r8
inc esi
jmp above

next: 
pop r8
mov esi,fname2

above2:
mov al,[r8]
cmp al,00
je next2
mov [esi],al
inc r8
inc esi
jmp above2

next2:
operate 2,fname1,000000q,0777q
mov [fd1],rax
mov rbx,rax
operate 0,rbx,buff,512
mov [bufflen],rax
operate 1,rbx,buff,[bufflen]
operate 85,fname2,0777q,0
operate 2,fname2,2,0777q
mov [fd2],rax
mov rbx,rax
operate 1,rbx,buff,[bufflen]
mov [bufflen],rax
operate 3,rbx,0,0
operate 3,[fd1],0,0
operate 1,1,msg12,msg12len
jmp end

err:
operate 1,1,msg11,msg11len
end:
operate 60,0,0,0

;output:
;c04l0513@c04l0513:~$ nasm -f elf64 as3.asm
;c04l0513@c04l0513:~$ ld -o a3 as3.o
;c04l0513@c04l0513:~$ ./a3 shrikant.txt bharti.txt
;Copy file successful
;c04l0513@c04l0513:~$ ./a3 shrikant.txt
;Error !


