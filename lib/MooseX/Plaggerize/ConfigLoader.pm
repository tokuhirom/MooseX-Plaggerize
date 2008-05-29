package MooseX::Plaggerize::ConfigLoader;
use strict;
use Moose::Role;
use YAML;

sub load_config {
    my ($self, $stuff) = @_;
    my $config = normalize($stuff);

    for my $plugin (@{ $config->{plugins} || [] }) {
        $self->load_plugin($plugin);
    }

    return $config;
}

sub normalize {
    my $stuff = shift;
    if (ref $stuff) {
        return $stuff;
    } else {
        open my $fh, '<:utf8', $stuff or die "$!: $stuff";
        $stuff = YAML::LoadFile($fh);
        close $fh;
        return $stuff;
    }
}

1;
