##===- Makefile -----------------------------------------------------------===##
# 
# This file licensed under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# 
##===----------------------------------------------------------------------===##

srcdir := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

include /home/projects/aie/tsuboi/mlir-aie/programming_examples/makefile-common

all: build/final.xclbin

targetname = myFirstProgram

trace_size = 32768

build/aie.mlir: ${srcdir}/aie2.py
	mkdir -p ${@D}
	python3 $< > $@

build/aie_trace.mlir: ${srcdir}/aie2.py
	mkdir -p ${@D}
	python3 $< -t ${trace_size} > $@

build/func.o: ${srcdir}/func.cc
	mkdir -p ${@D}
	cd ${@D} && xchesscc_wrapper ${CHESSCCWRAP2_FLAGS} -c $< -o ${@F}

build/final.xclbin: build/aie.mlir build/func.o
	mkdir -p ${@D}
	cd ${@D} && aiecc.py --aie-generate-cdo --no-compile-host --xclbin-name=${@F} \
				--aie-generate-npu --npu-insts-name=insts.txt $(<:%=../%)

build/trace.xclbin: build/aie_trace.mlir build/func.o
	mkdir -p ${@D}
	cd ${@D} && aiecc.py --aie-generate-cdo --no-compile-host --xclbin-name=${@F} \
				--aie-generate-npu --npu-insts-name=insts.txt $(<:%=../%)

${targetname}.exe: ${srcdir}/test.cpp
	rm -rf _build
	mkdir -p _build
	cd _build && ${powershell} cmake -E env CXXFLAGS="-std=c++23 -ggdb" cmake ${srcdir} -D CMAKE_C_COMPILER=gcc-13 -D CMAKE_CXX_COMPILER=g++-13 -DTARGET_NAME=${targetname} 
	cd _build && ${powershell} cmake --build . --config Release
ifeq "${powershell}" "powershell.exe"
	cp _build/${targetname}.exe $@
else
	cp _build/${targetname} $@ 
endif

run: ${targetname}.exe build/final.xclbin
	${powershell} ./$< -x build/final.xclbin -i build/insts.txt -k MLIR_AIE

run-1000: ${targetname}.exe build/final.xclbin build/insts.txt 
	${powershell} ./$< -x build/final.xclbin -i build/insts.txt -k MLIR_AIE --iters 1000 --warmup 100 --verbosity 0

run-10: ${targetname}.exe build/final.xclbin build/insts.txt 
	${powershell} ./$< -x build/final.xclbin -i build/insts.txt -k MLIR_AIE --iters 10 --verbosity 0

run_py: build/final.xclbin
	${powershell} python3 ${srcdir}/test.py -x build/final.xclbin -i build/insts.txt -k MLIR_AIE

trace: ${targetname}.exe build/trace.xclbin

	set -x
	${powershell} ./$< -x build/trace.xclbin -i build/insts.txt -k MLIR_AIE -t ${trace_size}
	/home/projects/aie/tsuboi/mlir-aie/programming_examples/utils/parse_trace.py --filename trace.txt --mlir build/aie_trace.mlir --colshift 1 > trace_4b.json

trace_py: build/trace.xclbin
	${powershell} python3 ${srcdir}/test.py -x build/trace.xclbin -i build/insts.txt -k MLIR_AIE -t ${trace_size}
	/home/projects/aie/tsuboi/mlir-aie/programming_examples/utils/parse_trace.py --filename trace.txt --mlir build/aie_trace.mlir --colshift 1 > trace_4b.json

clean_trace:
	rm -rf tmpTrace trace.txt trace*json

clean: clean_trace
	rm -rf build _build ${targetname}.exe
