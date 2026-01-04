build/test-cpu: test_cpu.cpp ../nttlib.cpp
	mkdir -p ${@D}
	g++-13 -o $@ $^ -std=c++23

test-cpu: build/test-cpu
	./$<