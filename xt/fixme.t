# In a test script like 't/test-fixme.t'
use Test::Fixme;

run_tests(
  where    => ['lib'],
  match    => 'FIXME',
  filename_match => qr/\.(pl|pm|xs)$/,
  skip_all => 0,
);

run_tests(
  where    => ['_generators'],
  match    => 'FIXME',
  filename_match => qr/\.(pl|pm|t|tt|xs)$/,
  skip_all => 0,
);

run_tests(
  where    => ['_generators/pod.tt'],
  match    => 'FIXME',
  filename_match => qr/\.(pod|tt)$/,
  skip_all => 0,
);