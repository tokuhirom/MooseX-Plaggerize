use inc::Module::Install;
name 'MooseX-Plaggerize';
all_from 'lib/MooseX/Plaggerize.pm';

requires 'Moose'        => '1.08';
requires 'Scalar::Util' => '1.19';

author_tests 'xt';

tests 't/*.t t/*/*.t t/*/*/*.t';
build_requires 'Test::More';
build_requires 'YAML';
auto_include;
WriteAll;
