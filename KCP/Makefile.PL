#
# Copyright (c) homqyy
#
use 5.026003;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'KCP',
    VERSION_FROM      => 'lib/KCP.pm', # finds $VERSION, requires EU::MM from perl >= 5.5
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/KCP.pm', # retrieve abstract from module
    AUTHOR            => 'homqyy <yilupiaoxuewhq@163.com>',
    LICENSE           => 'mit',
    MYEXTLIB          => "$ENV{KCP_LIB}",
    LIBS              => [], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => "-I. -I$ENV{KCP_INC_DIR}", # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
