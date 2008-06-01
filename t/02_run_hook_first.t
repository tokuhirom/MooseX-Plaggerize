use Moose;
use Test::More tests => 2;
use MooseX::Plaggerize;

my $context = Moose::Meta::Class->create_anon_class(
    roles        => ['MooseX::Plaggerize'],
)->construct_instance;

my $plugin = Moose::Meta::Class->create_anon_class()->construct_instance;

{
    $context->register_hook(
        'first' => $plugin,
        sub {
            ok 1, "this hook should run";
            return 0;
        }
    );
    $context->register_hook(
        'first' => $plugin,
        sub {
            ok 1, "this hook should run";
            return 1;
        }
    );
    $context->register_hook(
        'first' => $plugin,
        sub {
            ok 0, "this hook should not run";
            return 0;
        }
    );
}

$context->run_hook_first('first');

