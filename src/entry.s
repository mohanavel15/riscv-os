.section .text
.global _start
_start:
	csrr t0, mhartid
	addi t0, t0, 1
	li t1, 1024 * 4
	mul t1, t1, t0
	la sp, kernel_end
	add sp, sp, t1
	
	
	la t0, kmain
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

	csrr tp, mhartid	
	call set_cpu_count
	
	mret

kmain:
	bgtz tp, scheduler
	call setup_ram			
	call main
	ret

set_cpu_count:
    la t0, temp_mem
    amomax.d zero, tp, 0(t0)

done:
    ret

setup_ram:
	la t0, temp_mem
	ld t1, 0(t0)
	add t0, t1, 1
	li t1, 1024 * 4
	mul t0, t0, t1

	la t1, kernel_end
	add t0, t1, t0

	la t1, RAM_START_ADDRESS
	sd t0, 0(t1)

	ret
