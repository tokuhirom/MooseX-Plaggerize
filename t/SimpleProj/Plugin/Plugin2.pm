package t::SimpleProj::Plugin::Plugin2;
use MooseX::Plaggerize::Plugin;
our $CONTEXT;
our $ARGS;
our $CONFIG_FOO;

hook 'test2' => sub {
    my ($self, $c, $args) = @_;
    $CONTEXT = $c;
    $ARGS = $args;
    $CONFIG_FOO = $self->config->{foo};
};

1;
