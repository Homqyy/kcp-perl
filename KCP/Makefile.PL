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
    PREREQ_PM         => {
        'strict'        => 0,
        'warnings'      => 0,
        'Devel::PPPort' => '3.68',
    },
    ABSTRACT_FROM     => 'lib/KCP.pm', # retrieve abstract from module
    AUTHOR            => 'homqyy <yilupiaoxuewhq@163.com>',
    LICENSE           => 'mit',
    MYEXTLIB          => "$ENV{KCP_LIB}",
    LIBS              => ['-lkcp'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => "-I. -I$ENV{KCP_INC_DIR}", # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
      'meta-spec' => { version => 2 },
      resources => {
          repository => {
              type => 'git',
              url  => 'https://github.com/Homqyy/kcp-perl.git',
              web  => 'https://github.com/Homqyy/kcp-perl',
          },
      }})
   : ()
  ),
);
