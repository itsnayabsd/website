---
date: 2017-09-08 01:12:04 +5:30
category: embedded
layout: post
excerpt: Terms and it's definitions related to computers and embedded systems
title: Computer Glossary
comments: true
google_adsense: true
---
<h2 id="loadnstore">Load and Store</h2>
To operate on data in main memory, the data is first copied into registers. A **load** operation copies data from main memory into a register. A **store** operation copies data from a register into main memory.

## SDRAM
Synchronous Dynamic Random Access Memory. This is what we are using in our general purpose computers (Laptops and Desktops) as main memory (RAM). Generations of SDRAM include SDR (Single Data Rate) SDRAM, DDR (Double Data Rate) SDRAM, DDR2 SDRAM, DDR3 SDRAM and DDR4 SDRAM.
### Why SDRAM?
Modern CPU only does arithmetic and logical operations on registers. But CPU has very few registers, may be in terms of few bytes. To perform arithmetic and logical operations on large data, CPU needs larger memory. And then it uses <a href="#loadnstore">load and store</a> instructions to perform those operations on that data.

## Cache Memory
### Why and What is Cache Memory
For CPU, it takes hundreds of clock cycles to access the data from main memory because <a href="#cas latency">CAS latency</a> of SDRAM (main memory) is high. This slows down any CPU operation on that data. So we need faster memory than SDRAM. SRAM (Static Random Access Memory) does the trick. But it occupies larger space and more expensive than DRAM. So few kilo bytes of SRAM memory is placed as closer as possible to the CPU. This memory is called CPU cache and it contains the instructions and data which is used often now and in the near future for fastening the CPU operations.
### Questions to be asked
#### When and what data is stored in cache?
##### When the data or code is required again:
* Code and <a href="#scalar">scalar</a> accesses inside a loop are stored in cache.

```c
for (i = 0; i < 100; i++) {
	x[i] = x[i] + s;
}
```

##### When the adjacent code or data is needed soon:

* Basic blocks. i.e. the code block in which other functions are not called. All or most of next instructions in the basic blocks are stored in cache.
* When scanning all the elements in an array.

<h2 id="cas latency">CAS Latency</h2>
Column Access Strobe (CAS) latency, or CL, is the delay time between the moment a memory controller tells the memory module to access a particular memory column on a RAM module, and the moment the data from the given array location is available on the module's output pins.

<h2 id="scalar">Scalar definition for programming</h2>
It's the individual element in a data structure. Like second element, `a[2]` in a 100 element array `a[100]`. It could be int, float, short or any datatype.

