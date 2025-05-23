# riscv-kernel

## Run
```sh
  $ zig build
  $ qemu-system-riscv64 -machine virt -bios zig-out/bin/riscv_kernel -serial mon:stdio -nographic
```

## References
- https://wiki.osdev.org/RISC-V_Bare_Bones
- https://wiki.osdev.org/RISC-V_Meaty_Skeleton_with_QEMU_virt_board
- https://github.com/riscv/riscv-isa-manual
- https://projectf.io/posts/riscv-cheat-sheet
- https://github.com/zig-osdev/riscv-barebones
