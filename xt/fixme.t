use strict;
use warnings;
use Test::More;
use Test::Fixme;

# NOTE: Test::Fixme (>= 0.14) plans internally inside run_tests(), so calling it
# several times at the top level dies with "You tried to plan twice". Wrapping each
# scan in its own subtest isolates those plans, so we keep the original per-area
# coverage (lib code, _generators code, pod templates) without that error.
subtest 'lib'                => sub { run_tests(where => ['lib'],                match => 'FIXME', filename_match => qr/\.(pl|pm|xs)$/); };
subtest '_generators'        => sub { run_tests(where => ['_generators'],        match => 'FIXME', filename_match => qr/\.(pl|pm|t|tt|xs)$/); };
subtest '_generators/pod.tt' => sub { run_tests(where => ['_generators/pod.tt'], match => 'FIXME', filename_match => qr/\.(pod|tt)$/); };

done_testing;
