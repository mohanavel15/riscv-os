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
	}

	PROVIDE(kernel_end = .);
}
