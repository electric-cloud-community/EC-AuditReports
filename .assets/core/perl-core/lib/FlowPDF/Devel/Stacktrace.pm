# WARNING
# Do not edit this file manually. Your changes will be overwritten with next FlowPDF update.
# WARNING

package FlowPDF::Devel::Stacktrace;
use strict;
use warnings;
use Data::Dumper;

my $TEMPLATES = {
    'package'    => 0,
    'filename'   => 1,
    'line'       => 2,
    'subroutine' => 3,
    'hasargs'    => 4
};
#                                 ($frame->[0]) > $frame->[1]:L$frame->[2]:$frame->[3]
our $STACKTRACE_FRAME_TEMPLATE = '({{package}}) :: {{filename}}:L{{line}}:{{subroutine}}';
sub new {
    my ($class) = @_;

    my $st = [];
    my $i = 0;

    while (1) {
        my @caller = caller($i);
        last unless @caller;
        unshift @$st, \@caller;
        if ($i >= 100) {
            last;
        }
        $i++
    }

    # removing last stack element if it is this function.
    my $function = __PACKAGE__ . '::new';
    if ($st->[-1]->[3] eq $function) {
        pop @$st;
    }
    bless $st, $class;
    return $st;
}


sub clone {
    my ($self) = @_;

    my @t = @$self;

    my $rv = \@t;
    bless $rv, ref $self;
    return $rv;
}

sub toString {
    my ($self) = @_;

    my $rv = '';
    my $shift = 0;
    for my $frame (@$self) {
        my $t = $self->interpolateTemplate($STACKTRACE_FRAME_TEMPLATE, $frame);
        $rv .= ' ' x $shift . "at $t\n";
        $shift++;
    }

    $rv = $rv if ($rv);
    $rv =~ s/^\s+//gs;
    return $rv;
}


sub interpolateTemplate {
    my ($self, $line, $frame) = @_;

    for my $k (keys %$TEMPLATES) {
        $line =~ s/\{\{$k\}\}/$frame->[$TEMPLATES->{$k}]/gs;
    }

    return $line;
}

1;

=head1 NAME

FlowPDF::Devel::Stacktrace

=head1 AUTHOR

CloudBees

=head1 DESCRIPTION

This module provides a stack trace functionality for FlowPDF.

It creates a stack trace which could be stored as object and then used in a various situations.

=head1 METHODS

=head2 new

=head2 Description

Creates new FlowPDF::Devel::Stacktrace object and stores stacktrace on the time of creation.
It means, that this object should be created right before it should be used if goal is to get current stacktrace.
Just note, that this call stores stacktrace on the moment of creation.

=head3 Parameters

=over 4

=item None

=back

=head3 Returns

=over 4

=item (FlowPDF::Devel::Stacktrace) A stack trace on the moment of invocation.

=back

=head3 Exceptions

=over 4

=item None

=back

=head3 Usage

%%%LANG=perl%%%

    my $st = FlowPDF::Devel::Stacktrace->new();

%%%LANG%%%


=head2 toString

=head2 Description

Converts a FlowPDF::Devel::StackTrace object into printable string.

=head3 Parameters

=over 4

=item None

=back

=head3 Returns

=over 4

=item (String) A printable stack trace.

=back

=head3 Exceptions

=over 4

=item None

=back

=head3 Usage

%%%LANG=perl%%%

    my $st = FlowPDF::Devel::Stacktrace->new();
    print $st->toString();

%%%LANG%%%


=head2 clone

=head2 Description

This function clones an existing FlowPDF::Devel::Stacktrace and returns new FlowPDF::Devel::Stacktrace reference that points to different FlowPDF::Devel::Stacktrace object.

=head3 Parameters

=over 4

=item None

=back

=head3 Returns

=over 4

=item (FlowPDF::Devel::Stacktrace) A clone of caller object.

=back

=cut

=head3 Exceptions

=over 4

=item None

=back

=head3 Usage

%%%LANG=perl%%%

    my $st = FlowPDF::Devel::Stacktrace->new();
    my $st2 = $st->clone();

%%%LANG%%%

=cut
