#--------------------------------------------------------------------
include	./Makefile.git
#--------------------------------------------------------------------
#nothing to do
clean	:
	   @ rm -fr $(APLR) $(APLR).tar.gz
	
#--------------------------------------------------------------------
dotar	:
	  @ echo "Preparing Tar file"
	  @ rm -fr $(APLR)
	  @ mkdir $(APLR)
	  @ cp -a					\
		AUTHORS					\
		BUILDING				\
		etc					\
		lib					\
		LICENSE					\
		man					\
		meson.build				\
		README					\
		script					\
		test					\
		test_cardinal				\
		test_long_integer			\
		ucsdpsys				\
		ucsdpsys_assemble			\
		ucsdpsys_charset			\
		ucsdpsys_compile			\
		ucsdpsys_depends			\
		ucsdpsys_disassemble			\
		ucsdpsys_downcase			\
		ucsdpsys_errors				\
		ucsdpsys_foto				\
		ucsdpsys_libmap				\
		ucsdpsys_librarian			\
		ucsdpsys_link				\
		ucsdpsys_littoral			\
		ucsdpsys_opcodes			\
		ucsdpsys_osmakgen			\
		ucsdpsys_pretty				\
		ucsdpsys_setup				\
		web					\
		$(APLR)
	  @ tar 					\
		zcf $(APLR).tar.gz			\
		$(APLR)
	  @ echo "Tar file is now ready"


#--------------------------------------------------------------------
#to generate a binary from the src.rpm
rpmbin	:  rpm
	   @ echo "Making RPM binary"
	   @ rm -fr $(RPMDIR)/RPMS/x86_64/$(APP)-*.x86_64.rpm
	   @ rpmbuild					\
		-v					\
		--rebuild				\
		$(RPMDIR)/SRPMS/$(APP)*.src.rpm
	   @ echo "RPM binary completed"

#to generate a an src.rpm file
rpm	:  spec
	   @ echo "Making RPM src"
	   @ mkdir -p $(RPMDIR)/SOURCES
	   @ rm -fr 					\
		$(RPMDIR)/SOURCES/$(APP)*.tar.gz	\
		$(RPMDIR)/SRPMS/$(APP)*.src.rpm
	   @ $(MAKE) -s dotar
	   @ mv $(APLR).tar.gz $(RPMDIR)/SOURCES/
	   @ rpmbuild -bs				\
		$(APP).spec
	   @ echo "RPM src completed"

#--------------------------------------------------------------------
spec	:  $(APP).spec.in
	   @ sed 					\
		-e 's/@@DIST@@/safe/g' 			\
		-e 's/@@APPN@@/$(APP)/g' 		\
		-e 's/@@VERSION@@/$(VERSION)/g'		\
		-e 's/@@RELEASE@@/$(RELEASE)/g'		\
                -e 's/@@PACKAGER@@/$(PACKAGER)/g'	\
		< $< > $(APP).spec
		
#--------------------------------------------------------------------
