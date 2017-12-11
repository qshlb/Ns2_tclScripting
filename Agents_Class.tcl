# -----------Attach agent to node

set ns [new Simulator]
set n0 [$ns node]
# instance of agent
set a1 [new Agent/TCP]
set a2 [new Agent/UDP]

$ns attach-agent $n0 $a1

#-----------Fetch port number to which agent is attached

set port1 [$a1 port]

#---------Connect agents

$ns connect $a1 $a2


# eg. of Agents :- TCP/Reno, TCP, TCP/NewReno, TCP/Sack1, TCPSink, SRM etc.


