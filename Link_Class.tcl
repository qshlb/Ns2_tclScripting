# two types :- simplex & duplex
# specify :- delay(ms), BW(mbps), QUEUE(DropTail, RED, CBQ, FQ, SFQ, DRR)

set ns [new Simulator]
set n0 [$ns node]
set n1 [$ns node]

#duplex connection

$ns duplex-link $n0 $n1 2Mb 5ms DropTail

#simplex connection with asymmetric channel capacity

$ns simplex-link $n0 $n1 2Mb 5ms DropTail
$ns simplex-link $n1 $n0 3Mb 5ms DropTail

#orientation of second wrt first node

$ns duplex-link-op $n0 $n1 orient right-up


