#MIT object Tcl

#------------Class
Class Name


#----------------constructor
Name instproc init { a } {
	$self instvar hobby age favColor
	$self set hobby "nothing"
	$self set age 0
	$self set favColor $a
}


#----------------destructor
Name instproc destroy{ } {
	puts "destroying..."
}




#-------------method of Class
Name instproc show { } {
	#use of instance variables
	$self instvar hobby age favColor
  	puts "swati's details :- $hobby & $age & $favColor "
}


#-----------Object of Class
#Name swati "red"

#------------attributes of Object
#swati set hobby "coding"
#swati set age 19
#swati set favColor "black"

#puts [swati set favColor]

#swati show

#swati destroy

#----------inheritance

Class Home -superclass Name

#Home h 
#puts "fdfd"
#puts [h set age] 
#puts "dvx"