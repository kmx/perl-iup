use strict;
use warnings;

use Module::Build;

eval { require Alien::IUP };
die "You need to have Alien::IUP installed\n" if $@;

#hack for generating *.pod documentation via './Build doc'
my $class = Module::Build->subclass(
  class => "Module::Build::Custom",
  code => 'sub ACTION_doc { system($^X, qw[_generators/proc-pod.tt2pod.pl -podtt _generators/pod.tt -pod pod]) }',
);

#my $builder = Module::Build->new(
my $builder = $class->new(
  module_name          => 'IUP',
  license              => 'mit',
  dist_abstract        => 'IUP bindings to Perl',
  dist_author          => 'KMX <kmx@cpan.org>',
  dist_version_from    => 'lib/IUP.pm',
  requires             => {
    'Carp'                 => 0,
    'constant'             => 0,
  },
  build_requires       => { # need to have for running: ./Build (install|test)
    'Module::Build'        => 0,
    'Alien::IUP'           => 0,
    'Test::More'           => 0,
    'Carp'                 => 0,
    'constant'             => 0,
  },
  configure_requires   => { # need to have for running: perl Buil.PL
    'Module::Build'        => 0,
    'Alien::IUP'           => 0,
  },
  add_to_cleanup       => [ 'IUP-*' ],
  c_source             => 'src', # ppport.h
  extra_compiler_flags => Alien::IUP->config('INC'),
  extra_linker_flags   => Alien::IUP->config('LIBS'),
  meta_merge => {
    keywords => [ qw[IUP portable toolkit graphical user interfaces tecgraf cross-platform GUI Windows GTK Motif X11] ],
    resources => {
      bugtracker => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=IUP',
      repository => 'http://github.com/kmx/perl-iup',
    }
  },
);

$builder->create_build_script();
