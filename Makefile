all: compile exe

compile:
	gcc -o main main.c

exe:
	time ./all.sh

clean:
	rm -f main *.bin*
