# 2016-12-01

proc main {route} {
	set v_distance 0
	set h_distance 0
	set heading {N}

	foreach {vertical horizontal} $route {
		set distance [string range $vertical 1 end]

		set heading [get_heading $heading [string index $vertical 0]]
		set v_distance [get_distance $heading $v_distance $distance]

		set distance [string range $horizontal 1 end]

		set heading [get_heading $heading [string index $horizontal 0]]
		set h_distance [get_distance $heading $h_distance $distance]
	}

	puts "horizontal: $h_distance vertical: $v_distance"
}

proc get_heading {heading direction} {
	return [string map {NR E SR W NL W SL E EL N WR N ER S WL S} ${heading}${direction}]
}

proc get_distance {heading position distance} {
	set operation [string map {S - N + W - E +} $heading]
	
	return [::tcl::mathop::$operation $position $distance]
}

main {L2 L3 L3 L4 R1 R2 L3 R3 R3 L1 L3 R2 R3 L3 R4 R3 R3 L1 L4 R4 L2 R5 R1 L5 R1 R3 L5 R2 L2 R2 R1 L1 L3 L3 R4 R5 R4 L1 L189 L2 R2 L5 R5 R45 L3 R4 R77 L1 R1 R194 R2 L5 L3 L2 L1 R5 L3 L3 L5 L5 L5 R2 L1 L2 L3 R2 R5 R4 L2 R3 R5 L2 L2 R3 L3 L2 L1 L3 R5 R4 R3 R2 L1 R2 L5 R4 L5 L4 R4 L2 R5 L3 L2 R4 L1 L2 R2 R3 L2 L5 R1 R1 R3 R4 R1 R2 R4 R5 L3 L5 L3 L3 R5 R4 R1 L3 R1 L3 R3 R3 R3 L1 R3 R4 L5 L3 L1 L5 L4 R4 R1 L4 R3 R3 R5 R4 R3 R3 L1 L2 R1 L4 L4 L3 L4 L3 L5 R2 R4 L2}
