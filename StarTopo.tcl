set ns [new Simulator]

#packets transfer color
$ns color 1 Blue
$ns color 2 Red

set namres [open startopo.nam w]
$ns namtrace-all $namres
	
proc finish {args} \
{
	global ns namres
	$ns flush-trace
	close $namres
	exec nam startopo.nam &
	exit 0
}
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 shape box
$n0 color green

$n1 color blue
$n2 color blue

$n3 color red 
$n4 color red


$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail
$ns duplex-link $n0 $n5 1Mb 10ms DropTail

$ns duplex-link-op $n0 $n2 orient up
$ns duplex-link-op $n0 $n1 orient left-up
$ns duplex-link-op $n0 $n4 orient left-down
$ns duplex-link-op $n0 $n3 orient right-up
$ns duplex-link-op $n0 $n5 orient right-down


set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
$tcp0 set fid_ 1
set tcpsink0 [new Agent/TCPSink]
$ns attach-agent $n2 $tcpsink0
$ns connect $tcp0 $tcpsink0
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $tcp0

set tcp1 [new Agent/TCP]
$ns attach-agent $n4 $tcp1
$tcp1 set fid_ 2
set tcpsink1 [new Agent/TCPSink]
$ns attach-agent $n3 $tcpsink1
$ns connect $tcp1 $tcpsink1
set ftp [new Application/FTP]
$ftp attach-agent $tcp1


$ns at 0.2 "$cbr start"
$ns at 0.5 "$ftp start"

$ns at 4.5 "$cbr stop"
$ns at 3.5 "$ftp stop"

$ns at 5.2 "finish"

$ns run