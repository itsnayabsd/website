---
layout: post
---
## Setting up kernel

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Note down the latest stable tag. Create a local branch for your development.
git tag -l
git checkout -b <local_branch_name> <stable_tag>
ex: git checkout -b 5.5.y v5.5

## Use the  following resources to browse code
https://elixir.bootlin.com/linux/latest/source

make cscope         # For current architecture

