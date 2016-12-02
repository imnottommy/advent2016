# 2016-12-01

namespace eval ::route {
	variable visited
}

proc ::route::main {route} {
	set v_distance 0
	set h_distance 0
	set heading {N}

	set ::route::visited(0,0) 1

	foreach {vertical horizontal} $route {
		set heading [get_heading $heading [string index $vertical 0]]
		get_distance $heading v_distance [string range $vertical 1 end] h_distance v_distance

		set heading [get_heading $heading [string index $horizontal 0]]
		get_distance $heading h_distance [string range $horizontal 1 end] h_distance v_distance
	}
}

proc ::route::get_heading {heading direction} {
	return [string map {NR E SR W NL W SL E EL N WR N ER S WL S} ${heading}${direction}]
}

proc ::route::get_distance {heading position distance h v} {
	upvar $position p
	upvar $h x
	upvar $v y

	set operation [string map {S - N + W - E +} $heading]

	for {set i 0} {$i < $distance} {incr i} {
			incr p ${operation}1

		if {[info exists ::route::visited($x,$y)]} {
			puts [expr abs($x) + abs($y)]
			exit 0
		}
		set ::route::visited($x,$y) 1
	}
}

::route::main {L2 L3 L3 L4 R1 R2 L3 R3 R3 L1 L3 R2 R3 L3 R4 R3 R3 L1 L4 R4 L2 R5 R1 L5 R1 R3 L5 R2 L2 R2 R1 L1 L3 L3 R4 R5 R4 L1 L189 L2 R2 L5 R5 R45 L3 R4 R77 L1 R1 R194 R2 L5 L3 L2 L1 R5 L3 L3 L5 L5 L5 R2 L1 L2 L3 R2 R5 R4 L2 R3 R5 L2 L2 R3 L3 L2 L1 L3 R5 R4 R3 R2 L1 R2 L5 R4 L5 L4 R4 L2 R5 L3 L2 R4 L1 L2 R2 R3 L2 L5 R1 R1 R3 R4 R1 R2 R4 R5 L3 L5 L3 L3 R5 R4 R1 L3 R1 L3 R3 R3 R3 L1 R3 R4 L5 L3 L1 L5 L4 R4 R1 L4 R3 R3 R5 R4 R3 R3 L1 L2 R1 L4 L4 L3 L4 L3 L5 R2 R4 L2}
