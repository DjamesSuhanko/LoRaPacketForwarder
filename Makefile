CC = g++
LIBS = -lwiringPi -lm -lpthread -lrt -lcrypt
CFLAGS = -std=c++14 -Wall -DLINUX -ILoRaLib/src/ -ILoRaLib/src/modules/ -ILoRaLib/src/linux-workarounds/SPI/

# Should be equivalent to your list of C files, if you don't build selectively
SRC = $(wildcard LoRaLib/src/linux-workarounds/SPI/*.cpp) $(wildcard LoRaLib/src/linux-workarounds/*.cpp) \
      $(wildcard LoRaLib/src/protocols/PhysicalLayer/*.cpp) $(wildcard LoRaLib/src/modules/RFM9x/*.cpp) \
      $(wildcard LoRaLib/src/modules/SX127x/*.cpp) $(wildcard LoRaLib/src/*.cpp) \
      $(wildcard smtUdpPacketForwarder/base64/*.c) $(wildcard smtUdpPacketForwarder/gpsTimestampUtils/*.cpp) \
      $(wildcard smtUdpPacketForwarder/*.cpp) $(wildcard *.cpp)

all: $(SRC)
	$(CC) -o LoRaPktFwrd $^ $(CFLAGS) -O3 $(LIBS)

debug: $(SRC)
	$(CC)  -o LoRaPktFwrd $^ -g3 -DRADIOLIB_VERBOSE $(CFLAGS) $(LIBS)

clean:
	rm -f ./LoRaPktFwrd
