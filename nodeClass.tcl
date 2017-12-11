#---- creating simulation instane

set ns [new Simulator]

#------creating node {Node Class}

set n0 [$ns node]

#-----chaning shape {circle, box, hexagon} of node

$n0 shape box

# reset all AGENTS of node

$n0 reset

#fetch node ID

$no id 

#-----Attach agent to node on a specific port

#[node-instance] attach-agent [agent-instance] optional:<Port_no


#---------Attach label to node

$n0 label "first_node"

#----------Fetch next available port number {alloc port to new agent on node}

$n0 alloc_port null_agent

#----------Fetch list of neighbors

$n0 neighbors

