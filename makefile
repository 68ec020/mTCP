SUBDIRS := $(wildcard apps/*/.)

.PHONY: all
all : $(SUBDIRS)

.PHONY: patch clean
patch clean : utils $(SUBDIRS)

.PHONY: $(SUBDIRS)
$(SUBDIRS) :
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: utils
utils :
	$(MAKE) -C $@
