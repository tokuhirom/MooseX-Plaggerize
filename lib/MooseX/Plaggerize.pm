package MooseX::Plaggerize;
use strict;
use Moose::Role;
use 5.00800;
our $VERSION = '0.02';
use Scalar::Util qw/blessed/;
use Carp;

has moosex_plaggerize_hooks => (
    is      => 'ro',
    isa     => 'HashRef',
    default => sub { {} },
);

sub load_plugin {
    my ($self, $args) = @_;
    $args = {module => $args} unless ref $args;
    my $module = $args->{module};
       $module = $self->resolve_plugin($module);
    Class::MOP::load_class($module);
    my $plugin = $module->new();
    $plugin->config($args->{config}) if defined $args->{config};
    $plugin->register( $self );
}

sub resolve_plugin {
    my ($self, $module) = @_;
    my $base = blessed $self or croak "this is instance method";
    return ($module =~ /^\+(.*)$/) ? $1 : "${base}::Plugin::$module";
}

sub register_hook {
    my ($self, @hooks) = @_;
    while (my ($hook, $plugin, $code) = splice @hooks, 0, 3) {
        $self->moosex_plaggerize_hooks->{$hook} ||= [];

        push @{ $self->moosex_plaggerize_hooks->{$hook} }, +{
            plugin => $plugin,
            code   => $code,
        };
    }
}

sub run_hook {
    my ($self, $hook, @args) = @_;
    return unless my $hooks = $self->moosex_plaggerize_hooks->{$hook};
    my @ret;
    for my $hook (@$hooks) {
        my ($code, $plugin) = ($hook->{code}, $hook->{plugin});
        my $ret = $code->( $plugin, $self, @args );
        push @ret, $ret;
    }
    \@ret;
}

1;
__END__

=for stopwords plagger API

=encoding utf8

=head1 NAME

MooseX::Plaggerize - plagger like plugin feature for Moose

=head1 SYNOPSIS

    # in main
    my $c = Your::Context->new;
    $c->load_config('config.yaml'); # feature of MooseX::Plaggerize::ConfigLoader
    $c->load_plugin('HTMLFilter::StickyTime');
    $c->load_plugin({module => 'HTMLFilter::DocRoot', config => { root => '/mobirc/' }});
    $c->run();

    package Your::Context;
    use Moose;
    with 'MooseX::Plaggerize', 'MooseX::Plaggerize::ConfigLoader';

    sub run {
        my $self = shift;
        $self->run_hook('response_filter' => $args);
    }

    package Your::Plugin::HTMLFilter::StickyTime;
    use strict;
    use MooseX::Plaggerize::Plugin;

    hook 'response_filter' => sub {
        my ($self, $context, $args) = @_;
    };

=head1 WARNING!! WARNING!!

THIS MODULE IS IN ITS BETA QUALITY. API MAY CHANGE IN THE FUTURE.

=head1 DESCRIPTION

MooseX::Plaggerize is Plagger like plugin system for Moose.

=head1 TODO

no plan :-)

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom@gmail.comE<gt>

=head1 SEE ALSO

L<Moose>, L<Class::Component>, L<Plagger>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
