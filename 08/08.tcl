set screen [lrepeat 6 [lrepeat 50 {.}]]

proc rect {screen a b} {
	for {set i 0} {$i < $b} {incr i} {
		for {set j 0} {$j < $a} {incr j} {
			lset screen $i $j {#}
		}
	}

	return $screen
}

proc rotate_column {screen a shift} {
	foreach row $screen {
		lappend column [lindex $row $a]
	}

	set length [llength $column]
	set column [lrange [join [list [lrange $column $length-$shift end] $column]] 0 $length-1]

	for {set i 0} {$i < $length} {incr i} {
		lset screen $i $a [lindex $column $i]
	}

	return $screen
}

proc rotate_row {screen a shift} {
	set length [llength [lindex $screen $a]]
	set row [lindex $screen $a]
	lset screen $a [lrange [join [list [lrange $row $length-$shift end] $row]] 0 $length-1]

	return $screen
}

proc display {screen} {
	foreach line $screen {
		puts [join $line]
	}
}

foreach line [split [read -nonewline stdin] "\n"] {
	switch -- [lindex $line 0] {
		rect {set screen [rect $screen {*}[split [lindex $line 1] {x}]]}
		rotate {set screen [rotate_[lindex $line 1] $screen [string range [lindex $line 2] 2 end] [lindex $line 4]]}
	}

	display $screen
	puts "\n"
}

puts [llength [lsearch -all [join $screen] {#}]]
