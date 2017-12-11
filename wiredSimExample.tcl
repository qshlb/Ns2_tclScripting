set ns [new Simulator]

# simulator results & nam results {trace-all is instproc}

set res [open results.dat w]
$ns trace-all $res

set nres [open out.nam w]
$ns namtrace-all $nres

set n0 [$ns node]
set n1 [$ns node]

set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp
set tcpSink [new Agent/TCPSink]
$ns attach-agent $n1 $tcpSink

$ns duplex-link $n0 $n1 1.2Mb 5ms DropTail

$ns connect $tcp $tcpSink

set ftp [new Application/FTP]
$ftp attach-agent $tcp

#schedule event { <simulator object> at <time> <event> }
$ns at 0.2 "$ftp start"
$ns at 2.0 "$ftp stop"

#flush buffer n start Nam
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
    #terminate current process
    exit 0
 }
 
 $ns at 2.2 "finish"
 $ns run
