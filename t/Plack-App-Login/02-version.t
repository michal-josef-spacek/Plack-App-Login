use strict;
use warnings;

use Plack::App::Login;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Plack::App::Login::VERSION, 0.09, 'Version.');
