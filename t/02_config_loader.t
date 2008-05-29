use strict;
use warnings;
use Test::More tests => 8;
use_ok 't::SimpleProj';
use File::Spec;

Moose::Util::apply_all_roles(t::SimpleProj->meta, 'MooseX::Plaggerize::ConfigLoader');

my $c = t::SimpleProj->new;
$c->load_config(File::Spec->catfile('t', 'config.yaml'));

do {
    is $t::SimpleProj::Plugin::Plugin1::TESTED, 0;
    $c->run_hook('test1');
    is $t::SimpleProj::Plugin::Plugin1::TESTED, 1;
};

do {
    is $t::SimpleProj::Plugin::Plugin2::TESTED, 0;
    $c->run_hook('test2', 'argument');
    is $t::SimpleProj::Plugin::Plugin2::TESTED, 1;
    isa_ok $t::SimpleProj::Plugin::Plugin2::CONTEXT, 't::SimpleProj';
    is $t::SimpleProj::Plugin::Plugin2::ARGS, 'argument';
    is $t::SimpleProj::Plugin::Plugin2::CONFIG_FOO, 'baz';
};
