include ./makePaths.mak ./makeDep.mak ./ObjectPaths.mak

MK := make -f makeSrc.mak
program_NAME := $(EXE_NAME)
program_C_SRCS += $(wildcard *.c) 
program_CXX_SRCS += $(wildcard *.cpp) 
program_C_OBJS := ${program_C_SRCS:.c=.o}
program_CXX_OBJS := ${program_CXX_SRCS:.cpp=.o}
program_OBJS += $(program_C_OBJS) $(program_CXX_OBJS)
program_INCLUDE_DIRS := 
program_LIBRARY_DIRS := C:\Cpp\CppUnit\lib
program_LIBRARIES := CppUnitBuild
LINK.cc := $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH)

CFLAGS += -DRUN_UNIT_TEST -D__UNIT_TESTS__ $(foreach MAKE_PATHS,$(MAKE_PATHS), -I$(MAKE_PATHS)) -O0 -g3 -Wall -c -fmessage-length=0 -std=c99   
CPPFLAGS += -DRUN_UNIT_TEST -D__UNIT_TESTS__ $(foreach MAKE_PATHS,$(MAKE_PATHS), -I$(MAKE_PATHS)) -O0 -g3 -Wall -c -fmessage-length=0   

.PHONY: all clean distclean

all: $(program_NAME)

$(program_NAME): $(program_OBJS) 
	-mkdir $(UNIT_TEST_DIR)/Objects
	$(foreach MAKE_DEPENDANCY,$(MAKE_DEPENDANCIES),cp makeSrc.mak makePaths2.mak $(P_DIR)$(MAKE_DEPENDANCY);) 
	$(foreach MAKE_DEPENDANCY,$(MAKE_DEPENDANCIES),$(MK) -C "$(P_DIR)$(MAKE_DEPENDANCY)";) 
	$(foreach MAKE_DEPENDANCY,$(MAKE_DEPENDANCIES),rm $(P_DIR)$(MAKE_DEPENDANCY)/makeSrc.mak $(P_DIR)$(MAKE_DEPENDANCY)/makePaths2.mak;) 
	$(LINK.cc)  -L$(program_LIBRARY_DIRS) $(program_OBJS) $(OBJ_PATHS) -o $(program_NAME) -l$(program_LIBRARIES)  

clean:
	@- $(RM) $(program_NAME)
	@- $(RM) $(program_OBJS) 
	@- -rm -rf $(UNIT_TEST_DIR)/Objects

distclean: clean


