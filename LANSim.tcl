set ns [new Simulator]
$ns color 1 Blue
$ns color 2 Red

set winfile [open winfile w]
set res [open LANres.tr w]
$ns trace-all $res
set namres [open LANnam.nam w]
$ns namtrace-all $namres

proc finish {args} \
{
	global ns res namres
	$ns flush-trace
	close $res
	close $namres
	exec nam LANnam.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n1 shape box
$n1 color blue 


$ns duplex-link $n2 $n0 2Mb 10ms DropTail
$ns duplex-link $n2 $n1 2Mb 10ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail
set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]

$ns duplex-link-op $n2 $n0 orient left-up
$ns duplex-link-op $n2 $n1 orient left-down
$ns simplex-link-op $n2 $n3 orient right
$ns simplex-link-op $n3 $n2 orient left

#set queue size to 20 for n2-n3 link
$ns queue-limit $n2 $n3 20

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp 
set tcpsink [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $tcpsink
$ns connect $tcp $tcpsink
$tcp set fid_ 1
$tcp set packet_size_ 552
set ftp [new Application/FTP]
$ftp attach-agent $tcp

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
set null [new Agent/Null]
$ns attach-agent $n5 $null
$ns connect $udp $null
$udp set fid_ 2
set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packet_size_ 1000
$cbr set rate_ 0.01Mb
$cbr set random_ false

$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 124.0 "$ftp stop"
$ns at 125.5 "$cbr stop"

proc plotWindow { tcpSource file } \
{
	global ns
	set time 0.1 
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $file "$now $cwnd"
	$ns at [expr $now+$time] "plotWindow $tcpSource $file"
}

$ns at 0.1 "plotWindow $tcp $winfile"
$ns at 125.0 "finish"
$ns run 



