#wired
#specify file in which u want to output traced data

# trace file:- has specific format

set trace [open result.tr w]
$ns trace-all $trace

# wireless

$ns use-newtrace


