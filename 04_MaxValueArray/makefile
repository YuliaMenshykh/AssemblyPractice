all: MaxValueArray

main: MaxValueArray.o 
	ld MaxValueArray.o -o MaxValueArray 

MaxValueArray.o :  MaxValueArray.asm 
	nasm -g -f elf64 -F dwarf MaxValueArray.asm -l MaxValueArray.lst

clean:
	rm -f ./MaxValueArray.o || true
	rm -f ./MaxValueArray.lst || true 
	rm -f ./MaxValueArray || true
