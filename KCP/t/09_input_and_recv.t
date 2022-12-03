#
# Copyright (c) homqyy
#
use strict;
use warnings;

use KCP;
use Test::More tests => 5;

#########################

sub output
{
    my ($data, $user) = @_;

    ok($user->{peer_kcp}->input($data), "input")
}

my $g_time = 10;
sub get_current_time
{
    my $kcp = shift;

    my $ret = $g_time;

    $g_time += $kcp->get_interval;
}

my (%user1, %user2);

my $kcp1 = KCP::new(1, \%user1)->set_output(\&output);
my $kcp2 = KCP::new(1, \%user2)->set_output(\&output);

$user1{kcp} = $kcp1;
$user1{peer_kcp} = $kcp2;

$user2{kcp} = $kcp2;
$user2{peer_kcp} = $kcp1;

# update
$kcp1->update(&get_current_time($kcp1));
$kcp2->update(&get_current_time($kcp2));

# kcp1 send data
$kcp1->send("123" x 10);
$kcp1->update(&get_current_time($kcp1));

# kcp2 recv data
$kcp2->update(&get_current_time($kcp2));

my $data;
ok($kcp2->recv($data, 30), "recv data");
is($data, "123" x 10, "check received data");

is($kcp2->recv($data, 30), undef, "no data to receive");

done_testing;