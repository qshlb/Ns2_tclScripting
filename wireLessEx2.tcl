set val(nn) 3
set val(x) 500
set val(y) 500
set val(rp) DSDV
set val(ll) LL
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail
set val(ifqlen) 50
set val(ant) Antenna/OmniAntenna
set val(prop) Propagation/TwoRayGround
set val(phy) Phy/WirelessPhy
set val(chan) Channel/WirelessChannel
set val(stop) 150

set ns [new Simulator]

set res [open res_WLEx2.tr w]
$ns trace-all $res
set namres [open nam_WLEx2.nam w]
$ns namtrace-all-wireless $namres 500 500

proc finish { } \
{
	global ns res namres
	$ns flush-trace
	close $res
	close $namres
	exec nam nam_WLEx2.nam &
	exit 0
}


create-god $val(nn)

set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

$ns node-config -adhocRouting $val(rp)\
-llType $val(ll)\
-macType $val(mac)\
-ifqType $val(ifq)\
-ifqLen $val(ifqlen)\
-antType $val(ant)\
-propType $val(prop)\
-phyType $val(phy)\
-channelType $val(chan)\
-topoInstance $topo\
-agentTrace ON\
-routerTrace ON\
-movementTrace ON\
-macTrace OFF\
-energyModel "EnergyModel"\
-rxPower 1.0\
-txpower 1.0\
-sleepPower 0.5\
-idlePower 0.1\
-initialEnergy 1000\
-transitionPower 0.2\
-transitionTime 0.001

$ns set WirelessNewTrace_ ON	

for {set i 0} {$i < $val(nn)} {incr i} {
	set n($i) [$ns node]	
}

for {set i 0} {$i < $val(nn)} {incr i} {
	$ns initial_node_pos $n($i) 30
}

$n(0) set X_ 5.0
$n(0) set Y_ 5.0
$n(0) set Z_ 0.0

$n(1) set X_ 490.0
$n(1) set Y_ 285.0
$n(1) set Z_ 0.0

$n(2) set X_ 150.0
$n(2) set Y_ 240.0
$n(2) set Z_ 0.0


$ns at 10.0 "$n(0) setdest 250.0 250.0 3.0"
$ns at 15.0 "$n(1) setdest 45.0 285.0 5.0"
$ns at 110.0 "$n(2) setdest 480.0 300.0 5.0"

set tcp [new Agent/TCP/Newreno]
#$tcp set class_ 2

set sinktcp [new Agent/TCPSink]
$ns attach-agent $n(0) $tcp 
$ns attach-agent $n(1) $sinktcp
$ns connect $tcp $sinktcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp


$ns at 10.0 "$ftp start"

for {set i 0} {$i < $val(nn)} {incr i} {
	$ns at $val(stop) "$n($i) reset"
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at 150.01 "puts \"end simulation.....\" ; $ns halt"

$ns run