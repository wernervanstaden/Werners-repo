include ./makePaths2.mak

LIB_DIR := $(UNIT_TEST_DIR)/Objects
C_SOURCES :=  $(wildcard *.c)
CPP_SOURCES := $(wildcard *.cpp)
C_OBJ := ${C_SOURCES:.c=.o}
CPP_OBJ := ${CPP_SOURCES:.cpp=.o}
OBJECTS : $(C_OBJ) $(CPP_OBJ)
	mv *.o $(LIB_DIR)
		
CFLAGS += -DRUN_UNIT_TEST -D__UNIT_TESTS__ $(foreach MAKE_PATH2,$(MAKE_PATHS2), -I$(P_DIR)$(MAKE_PATH2)) -O0 -g3 -Wall -fmessage-length=0 -std=c99
CPPFLAGS += -DRUN_UNIT_TEST -D__UNIT_TESTS__ $(foreach MAKE_PATH2,$(MAKE_PATHS2), -I$(P_DIR)$(MAKE_PATH2)) -O0 -g3 -Wall -fmessage-length=0 
	
