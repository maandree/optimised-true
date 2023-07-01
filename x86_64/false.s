/* See LICENSE file for copyright and license details. */

.text
.global _start
_start:
	mov $60,%rax  /* 60 is exit(2) */
	mov $1,%rdi   /* return code 1 */
	syscall
