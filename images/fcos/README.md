# System Images Directory

## 📁 Purpose

**DROP here system images (initramfs, kernel & rootfs)**

## Supported Image Types

This directory is designated for the following system images **fedoracoreos**:

- **initramfs** - Initial RAM filesystem
- **kernel** - Linux kernel image
- **rootfs** - Root filesystem image

## Usage Instructions

1. Place your system images in this directory
2. Ensure proper file naming conventions
3. Verify image integrity before deployment

## File Organization

```
fcos/
├── fedora-initramfs.img
├── fedora-kernel.img
└── fedora-rootfs.img
```

## Notes

- Images dropped here will be processed by the build system
- Maintain proper file permissions and ownership
- Keep backup copies of working images before updates