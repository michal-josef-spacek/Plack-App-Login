package Plack::App::Login;

use base qw(Plack::Component);
use strict;
use warnings;

use CSS::Struct::Output::Raw;
use Plack::Util::Accessor qw(css login_link login_title title tags);
use Tags::HTML::Page::Begin;
use Tags::HTML::Page::End;
use Tags::Output::Raw;
use Unicode::UTF8 qw(decode_utf8 encode_utf8);

sub call {
	my ($self, $env) = @_;

	$self->_tags;
	$self->tags->finalize;
	my $content = encode_utf8($self->tags->flush(1));

	return [
		200,
		[
			'content-type' => 'text/html; charset=utf-8',
		],
		[$content],
	];
}

sub prepare_app {
	my $self = shift;

	if (! $self->css || ! $self->css->isa('CSS::Struct::Output')) {
		$self->css(CSS::Struct::Output::Raw->new);
	}

	if (! $self->tags || ! $self->tags->isa('Tags::Output')) {
		$self->tags(Tags::Output::Raw->new('xml' => 1));
	}

	if (! $self->title) {
		$self->title('Login page');
	}

	if (! $self->login_link) {
		$self->login_link('login');
	}

	if (! $self->login_title) {
		$self->login_title('LOGIN');
	}

	return;
}

sub _css {
	my $self = shift;

	$self->css->put(
		['s', '.outer'],
		['d', 'position', 'fixed'],
		['d', 'top', '50%'],
		['d', 'left', '50%'],
		['d', 'transform', 'translate(-50%, -50%)'],
		['e'],

		['s', '.login'],
		['d', 'text-align', 'center'],
		['d', 'background-color', 'blue'],
		['d', 'padding', '1em'],
		['e'],

		['s', '.login a'],
		['d', 'text-decoration', 'none'],
		['d', 'color', 'white'],
		['d', 'font-size', '3em'],
		['e'],
	);

	return;
}

sub _tags {
	my $self = shift;

	$self->_css;

	Tags::HTML::Page::Begin->new(
		'css' => $self->css,
		'lang' => {
			'title' => $self->title,
		},
		'tags' => $self->tags,
	)->process;
	$self->tags->put(
		['a', 'class', 'outer'],

		['b', 'div'],
		['a', 'class', 'login'],
		['b', 'a'],
		['a', 'href', $self->login_link],
		['d', $self->login_title],
		['e', 'a'],
		['e', 'div'],
	);
	Tags::HTML::Page::End->new(
		'tags' => $self->tags,
	)->process;

	return;
}

1;

__END__
