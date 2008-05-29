package t::SimpleProj::Plugin::Plugin2;
use MooseX::Plaggerize::Plugin;
our $CONTEXT    = undef;
our $ARGS       = undef;
our $CONFIG_FOO = undef;
our $TESTED     = 0;

hook 'test2' => sub {
    my ($self, $c, $args) = @_;
    $TESTED=1;
    $CONTEXT = $c;
    $ARGS = $args;
    $CONFIG_FOO = $self->config->{foo};
};

1;
