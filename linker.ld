ENTRY(_start);

SECTIONS {
	. = 0x80000000;
	
	.text : ALIGN(4K) {
		*(.text);
	}

	.rodata : ALIGN(4K) {
		*(.rodata);
	}

	.data : ALIGN(4K) {
		*(.data);
	}
	
	.bss : ALIGN(4K) {		
		*(.bss);
		PROVIDE(stack_top = .);
		. += 4K;
	}

	PROVIDE(kernel_end = .);
}
