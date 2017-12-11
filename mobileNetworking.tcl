#STEPS

#Create Simulator object
#Create god {general operation director}
#Create topography object
#Configure attributes for wireless node
#Attach agent & application
#Connect them

create-god <no of nodes>

#topology

set topo [new Topography]

#Specify boundary of area in which node can move {res - grid resolution}

$topo load_Flatgrid <X> &tl;Y> res

#configure {options - addressingType, -llType etc.}

$ns node-config -options  

#-----Mobile Node Movement
 #1 random motion
  $[node-instance] random-motion 0 or 1

 #2 setting position
   $[node-instance] set X_ <x-coordinates>
   $[node-instance] set Y_ <y-coordinates>
   $[node-instance] set Z_ <z-coordinates>
 
 #3 setting movement{set future position}
 	 $[simulator-instance] at <time> $[node-instance] setdest <X> <Y> <speed>

 #4 Setting Radius of Node{range of wireless node}
 	[node-instance] radius <r>

 #5 Setting distance between nodes
 	[god-instance] set-dist <node_number> <node_number> <hop>
