build/test-ntt: test_ntt.cpp ../nttlib.cpp
	mkdir -p ${@D}
	g++-13 -o $@ $^ -std=c++23

build/test-ntt-divided: test_divided_ntt.cpp ../nttlib.cpp
	mkdir -p ${@D}
	g++-13 -o $@ $^ -std=c++23

test-ntt: build/test-ntt
	./$<

test-ntt-divided: build/test-ntt-divided
	./$<

