# AODV :- Ad hoc On demand Distance Vector Routing

set ns [new Simulator]
set res [open aodvres.tr w]
$ns trace-all $res
set namres [open aodvnam.nam w]
$ns use-newtrace
$ns namtrace-all-wireless $namres 500 500

set topo [new Topography]
$topo load_flatgrid 500 500

create-god 3

$ns node-config -adhocRouting AODV\
-llType LL\
-macType Mac/802_11\
-ifqType Queue/DropTail\
-ifqLen 50\
-antType Antenna/OmniAntenna\
-propType Propagation/TwoRayGround\
-phyType Phy/WirelessPhy\
-channelType Channel/WirelessChannel\
-topoInstance $topo\
-agentTrace ON\
-movementTrace ON\
-macTrace OFF\
-routerTrace ON

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$n0 set X_ 5.0
$n0 set Y_ 5.0
$n0 set Z_ 0.0

$n1 set X_ 490.0
$n1 set Y_ 285.0
$n1 set Z_ 0.0

$n2 set X_ 150.0
$n2 set Y_ 240.0
$n2 set Z_ 0.0

$ns initial_node_pos $n0 30
$ns initial_node_pos $n1 30
$ns initial_node_pos $n2 30

$ns at 10.0 "$n0 setdest 250.0 250.0 3.0"
$ns at 15.0 "$n1 setdest 45.0 285.0 5.0"
$ns at 110.0 "$n2 setdest 480.0 300.0 5.0"

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp
$tcp set class_ 2
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n1 $tcpsink
$ns connect $tcp $tcpsink
set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 10.0 "$ftp start"

$ns at 150.0 "$n0 reset"
$ns at 150.0 "$n1 reset"
$ns at 150.0 "$n2 reset"

$ns at 150.0 "$ns nam-end-wireless 150"
$ns at 150.0 "finish"
$ns at 150.01 "puts \"end simulation \"; $ns halt"

proc finish { } \
{
	global ns res namres
	$ns flush-trace
	close $res
	close $namres
	exec nam aodvnam.nam &
	exit 0
}
$ns run 
