CC = g++
CXXFLAGS = -std=c++11 -Wall

test : main.o mmap_helper.o
	$(CC) $(CXXFLAGS) $^ -o $@

mmap_helper.o : mmap_helper.cxx mmap_helper.hxx
	$(CC) $(CXXFLAGS) -c $< -o $@

main.o : main.cxx mmap_helper.hxx
	$(CC) $(CXXFLAGS) -c $< -o $@

.PHONY:
clean:
	-rm *.o
	-rm test
