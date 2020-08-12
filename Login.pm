package Plack::App::Login;

use base qw(Plack::Component);
use strict;
use warnings;

use Plack::Util::Accessor qw(css debug login_uri title tags);
use Plack::Request;
use Tags::Output::Raw;
use Unicode::UTF8 qw(decode_utf8 encode_utf8);

sub call {
	my ($self, $env) = @_;

	if (! $self->title) {
		$self->title('Login page');
	}

	if (! $self->tags || ! $self->tags->isa('Tags::Output')) {
		$self->tags(Tags::Output::Raw->new('xml' => 1));
	}

	if (! $self->login_uri) {
		$self->login_uri('login');
	}

	my $req = Plack::Request->new($env);
	my $email = $req->parameters->{'email'};

	$self->tags->put(
		['b', 'html'],
		['b', 'head'],
		['b', 'title'],
		['d', $self->title],
		['e', 'title'],
		$self->css ? (
			['b', 'style'],
			['a', 'type', 'text/css'],
			['d', $self->css], 
			['e', 'style'],
		) : (),
		['e', 'head'],
		['b', 'body'],
		['b', 'div'],

		['b', 'form'],
		['a', 'action', $self->login_uri],
		['a', 'method', 'get'],

		['b', 'label'],
		['a', 'for', 'email'],
		['d', 'E-mail:'],
		['e', 'label'],

		['b', 'input'],
		['a', 'type', 'text'],
		['a', 'name', 'email'],
		['a', 'id', 'email'],
		['e', 'input'],

		['d', ' '],

		['b', 'input'],
		['a', 'type', 'submit'],
		['a', 'value', decode_utf8('Přihlásit')],
		['e', 'input'],

		['e', 'form'],

		$self->debug ? (
			['b', 'br'],
			['e', 'br'],
			['d', decode_utf8('Výsledek:')],
			['d', $email],
		) : (),

		['e', 'div'],
		['e', 'body'],
		['e', 'html'],
	);

	$self->tags->finalize;

	return [
		200,
		[
			'content-type' => 'text/html; charset=utf-8',
		],
		[encode_utf8($self->tags->flush(1))],
	];
}

1;

__END__
