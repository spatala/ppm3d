SHELL := /bin/bash

CODEDIR = code
ANNDIR = ./ann_1.1.2
BLITZDIR = ./blitz/
# CPPFLAGS1 = -Wall -O3 -fPIC -shared -o $@ $? -lc -I$(ANNDIR)/include/ANN -I$(BLITZDIR) -fopenmp `pkg-config --cflags blitz`
# CPPFLAGS1 = -Wall -O3 -fPIC -shared -o $@ $? -lc -I$(ANNDIR)/include/ANN -I$(BLITZDIR) -fopenmp
CPPFLAGS1 = -Wall -O3 -fPIC -shared -o $@ $? -lc -I$(ANNDIR)/include/ANN -I$(BLITZDIR) -fopenmp
# LIBS = -lgomp -lm -lpthread -lX11 -L. -L$(ANNDIR)/lib -lANN
LIBS = -lgomp -lm -lpthread -L. -L$(ANNDIR)/lib -lANN
HEADERS = $(CODEDIR)/common.hpp $(CODEDIR)/experiment.hpp $(CODEDIR)/nograph.hpp
OBJECTS = $(CODEDIR)/common.o $(CODEDIR)/nograph.o $(CODEDIR)/experiment.o

all: point_match.so

%.o: %.cpp $(HEADERS)
	cd $(ANNDIR); make linuxsl-g++; cd ..
	$(CXX) $(CPPFLAGS1)


point_match.so: $(OBJECTS) $(ANNDIR)/lib/libANN.so
	echo $(CXX) $(CPPFLAGS1) $(CODEDIR)/point_match.cpp $(OBJECTS) $(ANNDIR)/lib/libANN.so -o point_match.so $(LIBS)
	$(CXX) $(CPPFLAGS1) $(CODEDIR)/point_match.cpp $(ANNDIR)/lib/libANN.so -shared -o point_match.so $(CODEDIR)/experiment.o $(OBJECTS) $(LIBS)

clean:
	rm $(OBJECTS) point_match.so
	cd $(ANNDIR); make realclean
