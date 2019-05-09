;Name: Shrikant Bharti
Roll_no. : 203702

%macro rw 4
mov rax, %1

mov rdi, %2
mov rsi, %3

mov rdx, %4

syscall
%endmacro

section .data
arr dd 12.3,14.2,23.4,16.3,11.5
msg1 db "Mean=",10
msg1len equ $-msg1
point db "."
plen equ $-point
cnt db 5
divisor dd 5.0
tent dd 10000.0


section .bss                                    
mean resd 1
mean1 rest 1
count resb 1
count1 resb 1
temp resb 1

section .text
global _start
_start:
mov cx,5                                                                            
mov esi,arr
fldz

up:fadd dword[esi]
   add esi,4
   dec cx 
   jnz up
   
fdiv dword[divisor]
fst dword[mean]
fmul dword[tent]
fbstp tword[mean1]

mov ebp,mean1
call display

rw 60,0,0,0

display:add ebp,9
        mov byte[count],10

above:cmp byte[ebp],00
      je skip
      cmp byte[count],02
       jne print
rw 1,1,point,plen 

print:mov al,byte[ebp]
      mov byte[count1],2

again1:rol al,4
       mov byte[ebp],al
       and al,0Fh
       cmp al,09h
       jbe down1
       add al,07h

down1:add al,30h
      mov byte[temp],al
      rw 1,1,temp,1
      mov al,byte[ebp]
      dec byte[count1]
      jnz again1
      

skip:dec ebp
     dec byte[count]
     jnz above

ret

;Output:
c04l0514@c04l0514:~$ nasm -f elf64 mmc2.asm
c04l0514@c04l0514:~$ ld -o mmc2 mmc2.o
c04l0514@c04l0514:~$ ./mmc2
15.54c04l0514@c04l0514:~$
     
