package t::SimpleProj::Plugin::Plugin1;
use MooseX::Plaggerize::Plugin;
our $TESTED = 0;

hook 'test1' => sub {
    $TESTED = 1;
};

1;
