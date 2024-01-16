BINARY = bin
CODEDIRS = $(shell find src -type d)
INCDIRS = include
OBJECTDIR = object
TARGETDIR = target

CC = g++
OPT = -O3
DEPFLAGS = -MP -MMD
LINKFLAGS = -lglfw -lGL
CFLAGS = -lglfw -lGL -lX11 -lpthread -lXrandr -lXi -ldl -Wall -Wextra -g $(foreach D,$(INCDIRS),-I$(D)) $(OPT) $(DEPFLAGS)

CFILES = $(foreach D,$(CODEDIRS),$(wildcard $(D)/*.cpp)) $(foreach D,$(CODEDIRS),$(wildcard $(D)/*.c))
OBJECTS = $(patsubst src/%,$(OBJECTDIR)/%,$(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(CFILES))))
DEPS = $(patsubst %.o,%.d,$(OBJECTS))

GREEN = \033[1;32m
BLUE = \033[1;34m
ORANGE = \033[1;33m
LIGHTPURPLE = \033[1;35m
WHITE = \033[1;37m

all: ./$(TARGETDIR)/$(BINARY)
	@echo -e "$(GREEN)Successfully Compiled :3"

./$(TARGETDIR)/$(BINARY): $(OBJECTS) | target
	@echo -e "$(BLUE)Linking"
	@$(CC) $(LINKFLAGS) -o $@ $^ 

target:
	@mkdir ./$(TARGETDIR)

$(OBJECTDIR)/%.o: src/%.cpp | object
	@echo -e "$(ORANGE)Compiling $(LIGHTPURPLE)'$^'"
	@$(CC) $(CFLAGS) -c -o $@ $^

$(OBJECTDIR)/%.o: src/%.c | object
	@echo -e "$(ORANGE)Compiling $(LIGHTPURPLE)'$^'"
	@$(CC) $(CFLAGS) -c -o $@ $^

object:
	@mkdir -p $@

clean:
	@rm -rf $(BINARY) $(OBJECTDIR) $(DEPS) $(TARGETDIR)
	@echo -e "$(GREEN)All Clean"

run: all
	@echo -e -n "$(WHITE)"
	./$(TARGETDIR)/$(BINARY)

uwu:
	@echo -e "$(WHITE)owo"
