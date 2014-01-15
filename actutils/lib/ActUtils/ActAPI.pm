package ActUtils::ActAPI;

use strict;
use warnings;

use Moo;
use Sub::Quote;
use LWP::UserAgent;
use JSON;

=head1 NAME

=head1 DESCRIPTION

=head2 ACCESSORS

=head3 url

=cut

has url => (
    is => 'rw',
);

=head3 api_key

=cut

has api_key => (
    is => 'rw',
);

=head3 agent

HTTP user agent object, defaults to a LWP::UserAgent instance.

=cut

has agent => (
    is => 'rw',
    lazy => 1,
    default => sub {LWP::UserAgent->new;},
);

=head3 status_line

HTTP status line.

=cut

has status_line => (
    is => 'rwp',
    lazy => 1,
    default => quote_sub q{return '';},
);

=head2 METHODS

=head3 talks

=cut

sub talks {
    my ($self, %args) = @_;
    Dancer::Logger::warning("A ", \%args);
    # reset status line
    $self->_set_status_line('');

    # construct url and request
    my $talks_url = $self->_construct_url('get_talks', %args);
    my $response = $self->agent->get($talks_url);

     # save status line
    $self->_set_status_line($response->status_line);

    unless ($response->is_success) {
        return;
    }

    return from_json($response->content);
}

sub _construct_url {
    my ($self, $method, %args) = @_;
    my $api_url;

    $api_url = $self->url . "/api/$method?api_key=" . $self->api_key;

    if ($args{fields}) {
        $api_url .= '&fields=' . join(',', @{$args{fields}});
    }
    Dancer::Logger::warning("API URL: ", $api_url);
    return $api_url;
}

=head1 AUTHOR

Stefan Hornburg (Racke), <racke@linuxia.de>

=head1 LICENSE AND COPYRIGHT

Copyright 2013 Stefan Hornburg (Racke) <racke@linuxia.de>.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut

1;
