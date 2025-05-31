.section .text
.global _start
_start:
	la sp, stack_top

	la t0, main
	csrw mepc, t0

	# https://github.com/mit-pdos/xv6-riscv/blob/riscv/kernel/start.c
	csrr t0, mstatus

	li t1, 3
	slli t1, t1, 11
	not t1, t1
	and t0, t0, t1

	li t1, 1
	slli t1, t1, 11
	or t0, t0, t1
	
	csrw mstatus, t0

	csrw satp, zero

	li t0, 0xffff
	csrw medeleg, t0
	csrw mideleg, t0

	csrr t0, sie
	or t0, t0, 0x222
	csrw sie, t0

	li t0, 0x3fffffffffffff
	csrw pmpaddr0, t0
	csrw pmpcfg0, 0xf
	
	mret
