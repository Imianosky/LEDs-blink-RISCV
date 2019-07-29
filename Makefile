PROGRAM ?= LEDs-blink

$(PROGRAM): $(wildcard *.c) $(wildcard *.h) $(wildcard *.S)
	$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.c %.S,$^) $(LOADLIBES) -lm $(LDLIBS) -o $@ 

clean:
	rm -f $(PROGRAM) $(PROGRAM).hex
