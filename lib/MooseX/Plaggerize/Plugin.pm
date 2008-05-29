package MooseX::Plaggerize::Plugin;
use Moose;
use Scalar::Util qw/blessed/;
use Sub::Exporter;
use Carp;

{
    my $CALLER;
    my $HOOK_STORE = {};

    my %exports = (
        register => sub {
            sub {
                my ( $self, $c ) = @_;
                my $proto = blessed $self or confess "this is instance method: $self";

                for my $row ( @{ $HOOK_STORE->{$proto} || [] } ) {
                    my ( $hook, $code ) = @$row;
                    $c->register_hook( $hook, $self, $code );
                }
            }
        },
        hook => sub {
            sub {
                my ( $hook, $code ) = @_;
                my $caller = caller(0);
                push @{ $HOOK_STORE->{$caller} }, [ $hook, $code ];
            }
        },
    );

    my $exporter = Sub::Exporter::build_exporter(
        {
            exports => \%exports,
            groups  => { default => [':all'] }
        }
    );

    sub import {
        $CALLER = caller();

        strict->import;
        warnings->import;

        return if $CALLER eq 'main';

        Moose::init_meta($CALLER);
        Moose->import( { into => $CALLER } );

        $CALLER->meta->add_attribute(
            config => (
                is       => 'rw',
                isa      => 'HashRef',
            ),
        );

        goto $exporter;
    }
}

1;
__END__

=head1 NAME

MooseX::Plaggerize::Plugin - plugin

=head1 SYNOPSIS

    package Your::Plugin::Foo;
    use MooseX::Plaggerize::Plugin;


