.text
.global _start
_start:
	mov $60,%rax   /* 60 is exit(2) */
	xor %rdi,%rdi  /* return code 0 */
	syscall

