;Name : Shrikant Bharti
;R_no : 203702
;div : 7 G1 SYBtech CSE

section .data
gmsg db 10,10,"The contents of GDTR are:",10
gmsg_len equ $-gmsg

lmsg db 10,10,"The contents of LDTR are:",10
lmsg_len equ $-lmsg

imsg db 10,10,"The contents of IDTR are:",10
imsg_len equ $-imsg

tmsg db 10,10,"The contents of TR are:",10
tmsg_len equ $-tmsg

mmsg db 10,10,"The contents of MSW/CRO are:",10
mmsg_len equ $-mmsg

pro db 10,10, "The processor is in protected mode:"
pro_len equ $-pro

real db 10,10,"The processor is in real mode"
real_len equ $-real

col db ":"
col_len equ $-col

nline db 10,10
nlen equ $-nline

section .bss

		buff resb 4
		gdt1 resb 6
		idt1 resb 6
		ldt1 resb 2
		t1 resb 2
		msw1 resb 4
		
%macro display 4                                    
		mov rax,%1
		mov rdi,%2
		mov rsi,%3
		mov rdx,%4
		syscall
%endmacro

section .text
	global  _start
	
_start:
	
			smsw eax
			mov [msw1],eax
			bt eax,0
			jc protected
			display 1,1,real,real_len
			jmp end
			
protected:
			display 1,1,pro,pro_len
			sgdt [gdt1]
			sldt [ldt1]
			sidt [idt1]
			str [t1]
			
			display 1,1,gmsg,gmsg_len
			mov bx,[gdt1+4]
			call original_ascii
			mov bx,[gdt1+2]
			call original_ascii
			display 1,1,col,col_len
			mov bx,[gdt1]
			call original_ascii
			
			display 1,1,lmsg,lmsg_len
			mov bx,[ldt1]
			call original_ascii
			
			display 1,1,imsg,imsg_len
			mov bx,[idt1+4]
			call original_ascii
			mov bx,[idt1+2]
			call original_ascii
			display 1,1,col,col_len
			mov bx,[idt1]
			call original_ascii
			
			display 1,1,tmsg,tmsg_len
			mov bx,[t1]
			call original_ascii
			
			display 1,1,mmsg,mmsg_len
			mov bx,[msw1+2]
			call original_ascii
			mov bx,[msw1]
			call original_ascii
			
			
end:

			display 1,1,nline,nlen
			display 60,0,0,0
			
	original_ascii:
					mov rax,0
					mov rcx,4
					mov edi,buff
				up2:rol bx,4
					mov dl,bl
					and dl,0fh
					cmp dl,09h
					jbe down2
					add dl,07h
				down2:add dl,30h
				mov [edi],dl
				inc edi
				loop up2
				display 1,1,buff,4
	ret

;c04l0511@c04l0511:~$ nasm -f elf64 regcontent.asm
;c04l0511@c04l0511:~$ ld -o regcontent regcontent.o
;c04l0511@c04l0511:~$ ./regcontent
;
;
;The processor is in protected mode:
;
;The contents of GDTR are:
;77A0C000:007F
;
;The contents of LDTR are:
;FFFF
;
;The contents of IDTR are:
;FF574000:0FFF
;
;The contents of TR are:
;0040
;
;The contents of MSW/CRO are:
;80050033

