MASTER_BOARD_SDK = master-board/sdk/master_board_sdk
BUILD_DIR = $(MASTER_BOARD_SDK)/build
BIN_DIR = bin
EXAMPLE_DIR = $(MASTER_BOARD_SDK)/example
SRC_DIR = $(MASTER_BOARD_SDK)/src
INCLUDE_DIR = $(MASTER_BOARD_SDK)/include/

CC = g++
CFLAGS  = -g -Wall -std=c++11
INCLUDES = -I $(INCLUDE_DIR)

default: all

%.o: $(EXAMPLE_DIR)/%.cpp
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -o $(BUILD_DIR)/$@ -c $^

%.o: src/%.cpp
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -o $(BUILD_DIR)/$@ -c $^

%.o: $(SRC_DIR)/%.cpp
	mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) $(INCLUDES) -o $(BUILD_DIR)/$@ -c $^

%.o: tests/%.cpp
	mkdir -p $(BUILD_DIR)
	pkg-config --atleast-version=3.1 catch2
	$(CC) $(CFLAGS) $(INCLUDES) $(shell pkg-config --cflags catch2) -std=c++17 -o $(BUILD_DIR)/$@ -c $^

one_leg_control: one_leg_control.o ESPNOW_manager.o ESPNOW_types.o Link_manager.o ETHERNET_types.o master_board_interface.o motor.o motor_driver.o basic_mouvements.o
	mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(BIN_DIR)/one_leg_control $(addprefix $(BUILD_DIR)/,$^) -pthread

all: clear clean one_leg_control

clean: 
	#$(RM) -rf $(BUILD_DIR)
	$(RM) -rf $(BIN_DIR)

clear:
	clear
