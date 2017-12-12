set ns [new Simulator]

set namres [open meshTopo.nam w]
$ns namtrace-all $namres

proc finish {args} \
{
	global ns namres
	$ns flush-trace
	close $namres
	exec nam meshTopo.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

$ns duplex-link $n0 $n1 1Mb 2ms DropTail
$ns duplex-link $n0 $n3 1Mb 2ms DropTail
$ns duplex-link $n0 $n4 1Mb 2ms DropTail
$ns duplex-link $n0 $n2 1Mb 2ms DropTail 

$ns duplex-link $n1 $n2 1Mb 2ms DropTail
$ns duplex-link $n1 $n3 1Mb 2ms DropTail
$ns duplex-link $n1 $n4 1Mb 2ms DropTail

$ns duplex-link $n2 $n3 1Mb 2ms DropTail
$ns duplex-link $n2 $n4 1Mb 2ms DropTail

$ns duplex-link $n3 $n4 1Mb 2ms DropTail

$ns duplex-link-op $n1 $n2 orient left-down
$ns duplex-link-op $n1 $n0 orient right-down
$ns duplex-link-op $n0 $n4 orient down
$ns duplex-link-op $n2 $n3 orient down

set tcp [new Agent/TCP]
set tcpsink [new Agent/TCPSink]

$ns attach-agent $n1 $tcp
$ns attach-agent $n4 $tcpsink
$ns connect $tcp $tcpsink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.2 "$ftp start"
$ns at 5.0 "$ftp stop"

$ns at 5.1 "finish"
$ns run

