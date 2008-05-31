package MooseX::Plaggerize::PluginLoader;
use strict;
use Moose::Role;

sub load_plugins_from_config {
    my ($self, $config) = @_;

    for my $plugin (@{ $config->{plugins} || [] }) {
        $self->load_plugin($plugin);
    }

    return $config;
}

1;
__END__

=for stopwords plugins config.yaml plagger

=head1 NAME

MooseX::Plaggerize::ConfigLoader - configuration file loader

=head1 SYNOPSIS

    package Your::Context;
    use Moose;
    with 'MooseX::Plaggerize', 'MooseX::Plaggerize::ConfigLoader';

=head1 PROVIDE METHOD

=over 4

=item $self->load_plugins_from_config($conf)

load plugins from plagger style configuration stuff.

=back

=head1 DESCRIPTION

load plugins from config.yaml or hashref.

=head1 SEE ALSO

L<Moose>, L<MooseX::Plaggerize>
