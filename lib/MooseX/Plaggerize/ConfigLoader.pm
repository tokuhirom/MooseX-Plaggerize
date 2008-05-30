package MooseX::Plaggerize::ConfigLoader;
use strict;
use Moose::Role;
use YAML;

sub load_config {
    my ($self, $stuff) = @_;
    my $config = do {
        if (ref $stuff) {
            $stuff;
        } else {
            open my $fh, '<:utf8', $stuff or die "$!: $stuff";
            $stuff = YAML::LoadFile($fh);
            close $fh;
            $stuff;
        }
    };

    for my $plugin (@{ $config->{plugins} || [] }) {
        $self->load_plugin($plugin);
    }

    return $config;
}

1;
__END__

=for stopwords plugins config.yaml

=head1 NAME

MooseX::Plaggerize::ConfigLoader - configuration file loader

=head1 SYNOPSIS

    package Your::Context;
    use Moose;
    with 'MooseX::Plaggerize', 'MooseX::Plaggerize::ConfigLoader';

=head1 DESCRIPTION

load plugins from config.yaml or hashref.

=head1 SEE ALSO

L<Moose>, L<MooseX::Plaggerize>
