use inc::Module::Install;
name 'MooseX-Plaggerize';
all_from 'lib/MooseX/Plaggerize.pm';

requires 'Moose' => '0.46';
requires 'Scalar::Util';

tests 't/*.t t/*/*.t t/*/*/*.t';
build_requires 'Test::More';
build_requires 'YAML';
use_test_base;
auto_include;
WriteAll;
