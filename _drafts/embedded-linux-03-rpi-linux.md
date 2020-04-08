---
layout : post
---
## Download the kernel

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Note down the latest stable tag. Create a local branch for your development.
```bash
git tag -l
git checkout -b <local_branch_name> <stable_tag>
```
ex: `git checkout -b 5.6.y v5.6`

## Compile kernel for RPI
```bash
export ARCH=arm64 # This should match one of the directories in `arch` folder.
export CROSS_COMPILE=arm-linux-rpi3-
```
The Linux kenel does have a generic `defconfig` for arm64 in the `arch/arm64/configs` directory.
```bash
make defconfig
```
