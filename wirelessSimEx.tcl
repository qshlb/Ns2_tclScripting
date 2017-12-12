set ns [new Simulator]

#god for 2 nodes
#general operational descriptor- storing the hop details in the network
create-god 2

#topology 
#{grid topo: each node in the network is connected with two neighbors along one or more dimensions.}
set topo [new Topography]
$topo load_flatgrid 880 880

set nres [open out.nam w]
$ns namtrace-all-wireless $nres 500 500


set res [open results.tr w]
$ns trace-all $res

# {DSR- dynamic source routing}
# LL - link layer
#ifqType - interface queue type

$ns node-config -adhocRouting AODV \
-llType LL \
-macType Mac/802_11 \
-ifqType Queue/DropTail \
-ifqLen 5 \
-antType Antenna/OmniAntenna \
-propType Propagation/TwoRayGround \
-phyType Phy/WirelessPhy \
-topoInstance $topo \
-channel [new Channel/WirelessChannel] \
-agentTrace OFF \
-movementTrace OFF \
-routerTrace ON \
-macTrace OFF


set n0 [$ns node]

set n1 [$ns node]


$n0 set X_ 100.0
$n0 set Y_ 200.0
$n0 set Z_ 0.0

$n1 set X_ 300.0
$n1 set Y_ 200.0
$n1 set Z_ 0.0

$ns at 0.1 "$n0 label node0"
$ns at 0.1 "$n1 label node1"

#size of nodes
$ns initial_node_pos $n0 30
$ns initial_node_pos $n1 20

$n0 random-motion 0
$n1 random-motion 0

set udp [new Agent/UDP]
$ns attach-agent $n0 $udp

set null [new Agent/Null]
$ns attach-agent $n1 $null

set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 1000
$cbr set interval_ 0.05
$cbr attach-agent $udp

$ns connect $udp $null

$ns at 1 "$cbr start"
$ns at 4 "$cbr stop"
$ns at 4.1 "finish"

#$ns at 10 "$ns nam-end-wireless 10"
#$ns at 10 "finish"

#$ns at 10.01 "puts \"end simulation\" ; $ns halt"

proc finish { } \
 {
 	global ns res nres
 	#clear buffer
 	$ns flush-trace
 	#close all files
    close $res
    close $nres
    #execute nam in BACKGROUND{&}
    exec nam out.nam &
    exit 0
 }
 
 puts "starting simulation..."
 $ns run
