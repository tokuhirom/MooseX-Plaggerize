use Moose;
use Test::More tests => 1;
use MooseX::Plaggerize;

my $context = Moose::Meta::Class->create_anon_class(
    roles        => ['MooseX::Plaggerize'],
)->construct_instance;

my $plugin = Moose::Meta::Class->create_anon_class()->construct_instance;

{
    $context->register_hook(
        'filter' => $plugin,
        sub {
            my ($self, $c, $txt) = @_;
            $txt . '1';
        }
    );
    $context->register_hook(
        'filter' => $plugin,
        sub {
            my ($self, $c, $txt) = @_;
            $txt . '2';
        }
    );
}

my ($got, ) = $context->run_hook_filter('filter', 'src');
is $got, 'src12';

