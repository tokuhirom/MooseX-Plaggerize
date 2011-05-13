use inc::Module::Install;
name 'MooseX-Plaggerize';
all_from 'lib/MooseX/Plaggerize.pm';

requires 'Moose'        => '2.0006';
requires 'Scalar::Util' => '1.19';

tests 't/*.t t/*/*.t t/*/*/*.t';
author_tests('xt');
test_requires 'Test::More';
WriteAll;
