use Mojolicious::Lite -signatures;

get '/' => sub ($c) {
  $c->render(text => "Hello Perl.");
};

app->start;
