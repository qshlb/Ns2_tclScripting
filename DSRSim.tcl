#DSR :- Dynamic source routing (eg. of Reactive routing protocol)

set ns [new Simulator]
set res [open aodvres.tr w]
$ns trace-all $res
set namres [open aodvnam.nam w]
$ns use-newtrace
$ns namtrace-all-wireless $namres 500 500

set topo [new Topography]
$topo load_flatgrid 500 500

create-god 3

$ns node-config -adhocRouting DSR\
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

for {set i 0} {$i < 10} {incr i} {
	set n_($i) [$ns node]
}

for {set i 0} {$i < 10} {incr i} {
	
	$n_($i) set X_ [expr rand()*500]
	$n_($i) set Y_ [expr rand()*400]
	$n_($i) set Z_ 0
}

for {set i 0} {$i < 10} {incr i} {
	$ns initial_node_pos $n_($i) 30
}


set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n_(0) $tcp
$tcp set class_ 2
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n_(9) $tcpsink
$ns connect $tcp $tcpsink
set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 2.0 "$ftp start"

for {set i 0} {$i < 10} {incr i} {
	$ns at 50.0 "$n_($i) reset"
}


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
