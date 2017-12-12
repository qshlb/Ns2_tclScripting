set ns [new Simulator]
$ns rtproto DV

set namres [open ringtopo.nam w]
$ns namtrace-all $namres

proc finish {args} \
{
	global ns namres
	$ns flush-trace
	close $namres
	exec nam ringtopo.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail
$ns duplex-link $n2 $n1 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n4 $n3 1Mb 10ms DropTail
$ns duplex-link $n4 $n5 1Mb 10ms DropTail

$ns duplex-link-op $n1 $n0 orient left-down
$ns duplex-link-op $n1 $n2 orient right-down
$ns duplex-link-op $n0 $n5 orient down
$ns duplex-link-op $n2 $n3 orient down
$ns duplex-link-op $n4 $n5 orient left-up
$ns duplex-link-op $n4 $n3 orient right-up

set tcp [new Agent/TCP]
$tcp set class_ 1
set tcpsink [new Agent/TCPSink]

$ns attach-agent $n1 $tcp
$ns attach-agent $n3 $tcpsink

$ns connect $tcp $tcpsink

set cbr [new Application/Traffic/CBR]
$cbr set packetSize_ 500
$cbr set interval_ 0.01
$cbr attach-agent $tcp

$ns at 0.2 "$cbr start"

# Break link n2---n3 at 3.0ms 
$ns rtmodel-at 3.0 down $n2 $n3

 


$ns at 5.0 "$cbr stop"

$ns at 5.1 "finish"
$ns run






