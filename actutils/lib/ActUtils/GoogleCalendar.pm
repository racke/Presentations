package ActUtils::GoogleCalendar;

use strict;
use warnings;

use Moo;
use Sub::Quote;
use Net::Google::Calendar;
use Net::Google::Calendar::Entry;

has url => (
    is => 'rw',
);

has gcal => (
    is => 'rw',
    lazy => 1,
    default => sub {Net::Google::Calendar->new(url => shift->url)},
);

sub events {
    my ($self) = @_;

    return $self->gcal->get_events;
}

sub create {
    my ($self, %args) = @_;
    my ($event, %entry);

    $entry{title} = $args{title};
    $entry{author} = $args{author};
    $entry{status} = $args{status};
    $entry{when} = [$args{from}, $args{to}];

    $event = Net::Google::Calendar::Entry->new();
    $event->title($args{title});
    $event->location('Hancock, NY');
    $event->status($args{status});
    $event->when($args{from}, $args{to});
    
    Dancer::Logger::warning("Event: ", $event);
    
    my $ret = $self->gcal->add_entry($event);

    Dancer::Logger::warning("Ret: ", \$ret);
}

1;
