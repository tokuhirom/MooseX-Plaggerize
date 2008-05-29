use strict;
use warnings;
use Test::More tests => 7;
use_ok 't::SimpleProj';

can_ok 't::SimpleProj', qw(
    moosex_plaggerize_hooks
    load_plugin
    register_hook
    run_hook
);

my $c = t::SimpleProj->new;
do {
    $c->load_plugin('Plugin1');
    is $t::SimpleProj::Plugin::Plugin1::TESTED, 0;
    $c->run_hook('test1');
    is $t::SimpleProj::Plugin::Plugin1::TESTED, 1;
};

do {
    $c->load_plugin({module => 'Plugin2', config => {foo => 'bar'}});
    $c->run_hook('test2', 'argument');
    isa_ok $t::SimpleProj::Plugin::Plugin2::CONTEXT, 't::SimpleProj';
    is $t::SimpleProj::Plugin::Plugin2::ARGS, 'argument';
    is $t::SimpleProj::Plugin::Plugin2::CONFIG_FOO, 'bar';
};
