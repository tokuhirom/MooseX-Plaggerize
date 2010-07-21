use inc::Module::Install;
name 'MooseX-Plaggerize';
all_from 'lib/MooseX/Plaggerize.pm';

requires 'Moose'        => '0.70';
requires 'Scalar::Util' => '1.19';

tests 't/*.t t/*/*.t t/*/*/*.t';
build_requires 'Test::More';
build_requires 'YAML';
use_test_base;
auto_include;
WriteAll;
