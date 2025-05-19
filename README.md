# riscv-kernel

## Run
```sh
  $ zig build
  $ qemu-system-riscv64 -machine virt -bios zig-out/bin/riscv_kernel -serial mon:stdio
```

## References
- https://wiki.osdev.org/RISC-V_Bare_Bones
