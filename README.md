# QZIP2 Compressor

A minimalistic implementation of [FrodoKEM](https://frodokem.org/) lattice encryption layer over a slightly improved Bzip2 compression. Inspired by https://github.com/microsoft/PQCrypto-LWEKE.

# Usage

A single file (de)compression / (de)encryption is supported. 

## With encryption

```bash
# compress the file and encrypt 
qzip2 -c file.txt -p test -o file.qzip2

# decrypt and decompress
qzip2 -d file.qzip2 -p test
```

## Without encryption

Without encryption, a modified Burrows–Wheeler transform is used which can improve compression rate for small (1KB) text files.

```bash
# compress
qzip2 -c file -o file.qzip2


# decompress
qzip2 -d file.qzip2
```

# Requirements 

Opam v4.1+ is required.

# Releases

