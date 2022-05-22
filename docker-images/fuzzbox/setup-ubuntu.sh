#!/bin/bash
#
# Ubuntu 18.04 AFL+LLVM environment setup script.
# Installs AFL, LLVM, and afl-utils.

if [ "$EUID" -ne 0 ]; then
	echo "Please run as root"
	exit
fi

# printf "[+] Installing basic dependencies\n"
# apt-get install -yqq python3 python3-dev python3-setuptools build-essential cgroup-bin git

printf "[+] Installing qemu_mode\n"
cd /AFLplusplus/
make
cd /AFLplusplus/qemu_mode

./build_qemu_support.sh
mv ../afl-qemu-trace /usr/local/bin/afl-qemu-trace-x86-64

CPU_TARGET=i386 ./build_qemu_support.sh
mv ../afl-qemu-trace /usr/local/bin/afl-qemu-trace-i386

CPU_TARGET=arm ./build_qemu_support.sh
mv ../afl-qemu-trace /usr/local/bin/afl-qemu-trace-arm

CPU_TARGET=aarch64 ./build_qemu_support.sh
mv ../afl-qemu-trace /usr/local/bin/afl-qemu-trace-aarch64

CPU_TARGET=mips ./build_qemu_support.sh
mv ../afl-qemu-trace /usr/local/bin/afl-qemu-trace-mips

printf "[+] Installing afl-utils\n"
cd /opt/aflbox/
git clone https://gitlab.com/rc0r/afl-utils.git
cd afl-utils
python3 setup.py install
echo "source /usr/local/lib/python3.10/dist-packages/exploitable-1.32_rcor-py3.10.egg/exploitable/exploitable.py" >> ~/.gdbinit
cd ..

LLVM_VER=9

printf "[+] Checking for LLVM / clang...\n"
CLANG=$(which clang) > /dev/null
if [ $? -eq 0 ]; then
	printf "[+] %s\n" "$($CLANG --version 2>&1 | head -n 1)"
	printf "[!] Existing LLVM / clang installation found; skipping LLVM install\n"
else
	printf "[+] Installing LLVM / clang\n"
	wget https://apt.llvm.org/llvm.sh
	chmod +x llvm.sh
	./llvm.sh $LLVM_VER
	for file in /usr/bin/llvm-*; do
		TGT=$(echo $file | sed "s/-$LLVM_VER//g")
		echo "Linking $file to $TGT"
		ln -s $file $TGT
	done
	CLANG=$(which clang)
	printf "[+] %s\n" $($CLANG -v | head -n 1)
fi

# printf "[+] Checking for AFL...\n"
# AFLFUZZ=$(which afl-fuzz)
# if [ $? -eq 0 ]; then
# 	printf "[+] %s\n" "$($AFLFUZZ | head -n 1)"
# 	printf "[!] Existing AFL installation found; skipping AFL install\n"
# else
# 	printf "[+] Building and installing AFL\n"
# 	# git clone --single-branch --branch afl-continue-core-search https://github.com/qlyoung/AFL.git
# 	git clone https://github.com/AFLplusplus/AFLplusplus.git AFL
# 	cd /opt/aflbox/AFL
# 	make
# 	cd /opt/aflbox/AFL/llvm_mode
# 	make
# 	cd ..
# 	cd /opt/aflbox/AFL/qemu_mode
# 	STATIC=1 ./build_qemu_support.sh
# 	cd ..
# 	make install
# 	cd ..
# 	rm -rf AFL
# fi

printf "[+] All done, see README.md for further instructions\n"
