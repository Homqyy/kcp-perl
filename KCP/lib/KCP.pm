#
# Copyright (c) homqyy
#
package KCP;

use 5.026003;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use KCP ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('KCP', $VERSION);

# Preloaded methods go here.

1;
__END__

=head1 NAME

KCP - Perl extension for skywind3000/kcp

=head1 VERSION

 v0.01

=head1 SYNOPSIS

  use KCP;

  ...

  my $kcp = KCP::new($conv, $user);

  $kcp->set_mode("fast")->set_output(\&output);

  ...

  # scheduled call

  $kcp->update($current_millisec);

  ...

  # to send $data

  $kcp->send($data);
    or print "send error\n";
  
  ...

  # to recv data

  $kcp->recv($data)
    or print "recv error\n";

=head1 DESCRIPTION

extension for skywind3000/kcp.

=head2 new( $conv[, $user] )

Create a KCP instance, such as:

  my $kcp = KCP::new($conv, $user);

C<$conv> is conversation ID of KCP. 
C<$user> is user data and it will be deliveried to output subroutine (see L<KCP::set_output> for more details). 
So you can send output data that is from kcp with C<$user>.

The C<$user> is optional, so you can do this:

  my $kcp = KCP::new($conv);

But normally to provide it.

Finally, return instance of 'KCP' upon successful, otherwise return C<undef>.

=head2 set_output( &output )

Set a callback for send data. The callback will be invoked When KCP want to send data.

  sub my_output
  {
      my ($data, $socket) = @_;

      $socket->send($data, 0);
  }

  ... # include creating a socket

  my $kcp = KCP::new($conv, $socket)
              or die "KCP::new is failed\n";

  $kcp->set_output(\&my_output); # set callback

  ...

As shown above, deliver a C<$socket> to C<my_output> subroutine and send data with the C<$socket>.

C<output> parameter is a referrence of subroutine and carry 2 parameters: C<$data> and C<$user>.
The C<$user> is from C<KCP::new>.

Finally, it return instance of KCP. So you can do this:

  $kcp->setoutput(\&my_output)->update($current);

=head2 set_mode( $mode )

Set mode of KCP. mode C<"normal"> and C<"fast"> was be supported.

  set_mode("normal"); 

or

  set_mode("fast");

C<"normal"> is equal to

  $kcp->nodelay(
      nodelay   => 0,
      interval  => 40,
      resend    => 0,
      disable_congestion_control => 0
  );

C<"fast"> is equal to

  $kcp->nodelay(
      nodelay   => 1,
      interval  => 10,
      resend    => 2,
      disable_congestion_control => 1
  );

see C<KCP::nodelay> for more details.

=head2 nodelay( [%options] )

Extension for C<ikcp_nodelay()>. It is flexible for controlling to KCP.

  $kcp->nodelay(
      nodelay                    => ...,
      interval                   => ...,
      resend                     => ...,
      disable_congestion_control => ...,
  );

Throw a exception if given options is invalid, otherwise return instance of KCP.
So you can do this:

  $kcp->nodelay(nodelay => 1)->setoutput(\&my_output);

or to catch exception

  local $@;

  eval {
      $kcp->nodelay(nodelay => $nodelay_value);
  };

  if ($@) ...

=head3 option C<nodelay>

Do enable nodelay mode?
Valid value is C<0> and C<1>.
C<0> represent to disable, C<1> represent to enable.
The default is C<0> ( 'disable' ).

=head3 option C<interval>

KCP interval of working, Unit is ms and default is 40ms

=head3 option C<resend>

Do enable fast resend mode?
Valid value is C<0>, C<1> and C<2>.
C<0> represent to disable, C<1> represend to enable,
C<2> represend to resend immediately if skip 2 ACK.
The default is C<0> ( 'disable' ).

=head3 option C<disable_congestion_control>

Do disable congestion control?
Valid value is C<0> and C<1>.
C<0> represent enable, C<1> represend disable.
The default is C<0> ( 'enable' ).

=head2 update( $current_time )

Extension for C<ikcp_update()>. 

Unit of C<$current_time> is ms. The subroutine will return instance of KCP.

  use KCP;
  use Time::HiRes qw/ gettimeofday /;

  sub get_current()
  {
      my ($seconds, $microseconds) = gettimeofday;

      return $seconds * 1000 + $microseconds;
  }

  ...

  $kcp->update(&get_current);

  ...

=head2 send( $data )

Extension for C<ikcp_send()>.

Push C<$data> of user to KCP. Return undef if has error occur.

  $kcp->send($data)
    or return undef; # error

=head2 recv( $data )

=head2 input( $data )

Extension for C<ikcp_input()>.

Push C<$data> of transport layer to KCP. Return undef if has error occur.

  $socket->recv($data, 65536, 0); # receive data from socket

  $kcp->input($data)
    or return undef; # error

=head2 get_conv( [$data] )

Get conversation ID of the KCP instance if C<$data> isn't be given.
Otherwise Pick-up conversation ID from C<$data>.

  my $conv = $kcp->get_conv;

or

  $socket->recv($data, 65536, 0); # receive data from socket

  ...

  my $conv = $kcp->get_conv($data); # pick-up ID from the data

  ...

=head2 get_interval

Get interval of the KCP instance.

  my $interval = $kcp->get_interval;

=head1 SEE ALSO

=over

=item *

L<skywind3000/kcp|https://github.com/skywind3000/kcp>

=back

=head1 AUTHOR

homqyy, E<lt>yilupiaoxuewhq@163.comE<gt>

=head1 COPYRIGHT AND LICENSE

MIT License

Copyright (C) 2022 homqyy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=cut
