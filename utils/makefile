application = ptach

all : $(application)

.PHONY: clean
clean :
	@rm -f $(application)
	@rm -f $(application).o

$(application) : $(application).cpp
	wcl386 -fo=$@ $<
