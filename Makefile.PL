use lib '.';
use strict;
use warnings;

use inc::Module::Install;

# Definition.
abstract 'Plack login application.';
author 'Michal Josef Spacek <skim@cpan.org>';
author_requires 'English' => 0;
author_requires 'File::Object' => 0;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
license 'bsd';
name 'Plack-App-Login';
perl_version 5.008;
readme_from 'Login.pm';
recursive_author_tests('xt');
requires 'Encode' => 0;
requires 'English' => 0;
requires 'Error::Pure' => 0;
requires 'Plack::Util::Accessor' => 0;
requires 'Tags::Output::Raw' => 0;
requires 'Unicode::UTF8' => 0;
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Plack-App-Login';
resources 'homepage' => 'https://github.com/michal-josef-spacek/Plack-App-Login';
resources 'repository' => 'git://github.com/michal-josef-spacek/Plack-App-Login';
test_requires 'Error::Pure' => 0;
test_requires 'File::Object' => 0;
test_requires 'HTTP::Request' => 0;
test_requires 'Plack::Test' => 0;
test_requires 'Tags::Output::Indent' => 0;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
