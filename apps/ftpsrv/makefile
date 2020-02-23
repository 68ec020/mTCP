#
# FTPSRV makefile
#
#
# Possible optimizations for 8088 class processors
#
# -oa   Relax alias checking
# -ob   Try to generate straight line code
# -oe   Expand user functions inline (-oe=20 is default, adds lots of code)
# -oh   Enable repeated optimizations
# -oi   Generate certain lib funcs inline
# -oi+  Set max inline depth (C++ only, use -oi for C)
# -ok   Flowing of register save into function flow graph
# -ol   Loop optimizations
# -ol+  Loop optimizations plus unrolling
# -or   Reorder for pipelined (486+ procs); not sure if good to use
# -os   Favor space over time
# -ot   Favor time over space
# -ei   Allocate an "int" for all enum types
# -zp2  Allow compiler to add padding to structs
# -zpw  Use with above; make sure you are warning free!
# -0    8088/8086 class code generation
# -s    Disable stack overflow checking
# -zmf  Put each function in a new code segment; helps with linking

# This code is big by nature, so throw in a few more options to improve
# performance. We don't care about space so use -oe too.

tcp_h_dir = ../../tcpinc
tcp_c_dir = ../../tcplib
common_h_dir = ../../include

application = ftpsrv

target = dos
memory_model = -ml

compile_options = -bt=$(target) -0 $(memory_model) -d+ -DCFG_H='"$(application).cfg"' -oh -ok -ot -s -oa -ei -zp2 -zpw -we -ob -ol+ -oi+
compile_options += -i=$(tcp_h_dir) -i=$(common_h_dir)

tcpobjs = packet.o arp.o eth.o ip.o tcp.o tcpsockm.o utils.o timer.o ipasm.o trace.o

objs = $(application).o ftpcl.o ftpusr.o

vpath %.cpp $(tcp_c_dir)
vpath %.asm $(tcp_c_dir)

all : $(application).exe

.PHONY: clean
clean :
	@rm -f $(application).exe
	@rm -f $(application).map
	@rm -f $(objs) $(tcpobjs)

.PHONY: patch
patch :
	../../utils/ptach $(application).exe $(application).map $(memory_model)

%.o : %.asm
	wasm -0 $(memory_model) -fo=$@ $<

%.o : %.cpp $(application).cfg
	wpp $(compile_options) -fo=$@ $<

$(application).exe : $(tcpobjs) $(objs)
	wlink system dos option map option eliminate option stack=4096 name $@ file { $^ }
