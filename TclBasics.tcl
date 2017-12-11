#set a 2
#set b 3
#set c [expr $a+$b]
#puts "result is $c"


#-----------if else
#set x 30
#if { $x<20 } {
#	puts "inside if"
#} else {
#	puts "in else"
#}

#if [ expr $x==30 ] {
#	puts "second syntax"
#}

#-------------while loop
#set x 5
#while { $x>=0 } {
#	puts "counting $x"
#	set x [ expr $x - 1]
#}


#-------------for loop

#set n 5
#for {set i 0} {$i < $n} {incr i} {
	#puts "counting $i"
#}

#-------------Array {supports ASSOCIATIVE ARRAYS}

#set a(0) "s"
#set a("s") "w"
#set a(2) "a"
#set a(3) "t"
#set a(4) "i"

#puts "1st way"
#puts $a(0)
#puts $a("s")

#puts "2nd way"
#array set b {10,30}
#puts $b(0)


#------------------procedure

#proc fact { n } \
#{
#	set fact 1
#	for {set i 2} {$i <= $n} {incr i} {
#		set fact [expr $fact*$i]
#	}
#	puts $fact
#}

#fact 5


#------------------global vari in proc

#set x 1
#proc demo {args} \
#{
#	global x
#	set x 2
#}

#demo
#puts $x


#----------------file handling

#set f [open demo.txt w]
#puts $f "hey!! myself swati..."
#close $f

#set f [open demo.txt r]
#gets $f data
#puts $data
#close $f


