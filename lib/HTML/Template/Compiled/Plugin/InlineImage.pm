package HTML::Template::Compiled::Plugin::InlineImage;
# $Id: InlineImage.pm,v 1.2 2006/08/26 15:05:21 tinita Exp $
use strict;
use warnings;
use Carp qw(croak carp);
use HTML::Template::Compiled::Expression qw(:expressions);
use HTML::Template::Compiled;
use MIME::Base64;
our $VERSION = '0.01';
HTML::Template::Compiled->register(__PACKAGE__);


sub register {
    my ($class) = @_;
    my %plugs = (
        escape => {
            # <img src="<%= gd_object escape="INLINE_IMG"%>
            INLINE_IMG => sub {
                HTML::Template::Compiled::Plugin::InlineImage::inline(
                    type => 'png',
                    image => $_[0],
                );
            },
            INLINE_IMG_PNG => sub {
                HTML::Template::Compiled::Plugin::InlineImage::inline(
                    type => 'png',
                    image => $_[0],
                );
            },
            INLINE_IMG_GIF => sub {
                HTML::Template::Compiled::Plugin::InlineImage::inline(
                    type => 'gif',
                    image => $_[0],
                );
            },
            INLINE_IMG_JPEG => sub {
                HTML::Template::Compiled::Plugin::InlineImage::inline(
                    type => 'jpeg',
                    image => $_[0],
                );
            },
        },
    );
    return \%plugs;
}

sub inline {
    my (%args) = @_;
    my $image = $args{image};
    my $type = $args{type};
    my $binary = ref $image eq 'GD::Image'
        ? gd_to_binary($image,$type)
        : croak "unknown image type " . ref $image;
    my $base64 = encode_base64($binary);
    return "data:image/png;base64,$base64";
}

sub gd_to_binary {
    if ($_[1] eq 'png') { return $_[0]->png }
    if ($_[1] eq 'gif') { return $_[0]->gif }
    if ($_[1] eq 'jpeg') { return $_[0]->jpeg }
}

1;

__END__

=pod

=head1 NAME

HTML::Template::Compiled::Plugin::InlineImage - XML-Escaping for HTC

=head1 SYNOPSIS

The Perl code:

    use HTML::Template::Compiled::Plugin::InlineImage;

    my $htc = HTML::Template::Compiled->new(
        plugin => [qw(HTML::Template::Compiled::Plugin::InlineImage)],
        filename => "template.htc",
        tagstyle => [qw(+tt)],
    );
    $htc->param(gd_object => $gd);
    print $htc->output;

The Template:

    <html>
        <body>
        <img src="[%= gd_object escape="INLINE_IMG" %]" alt="[Rendered GD Image]">
        </body>
    </html>

=head1 DESCRIPTION

This is a plugin for L<HTML::Template::Compiled>. If you feed it GD-objects
(other image-object-types could be added in the future), then it
will render the object like described in RFC 2397
(http://www.ietf.org/rfc/rfc2397.txt).

=head1 ESCAPE TYPES

There are four escapy types at the moment:

=over 4

=item INLINE_IMG_PNG

renders as png

=item INLINE_IMG_GIF

renders as gif

=item INLINE_IMG_JPEG

renders as jpeg

=item INLINE_IMG

renders as png

=back

=head1 METHODS

=over 4

=item register

gets called by HTC

=back

=head1 SUBROUTINES

=over 4

=item inline

Arguments: a hash like

    type  => 'png', # or jpeg, gif
    image => $gd_object,

The subroutine determines which kind of image object we have
and calls the corresponding *_to_binary method. (At the moment
only L<GD> is supported.)

=item gd_to_binary

Arguments: ($gd_object, $type)

$type can be png, jpeg or gif.

Returns:

    data:image/$type;base64,$the_rendered_image_as_base64

=back

=cut

=head1 SEE ALSO

L<HTML::Template::Compiled>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by tina mueller

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.5 or,
at your option, any later version of Perl 5 you may have available.

