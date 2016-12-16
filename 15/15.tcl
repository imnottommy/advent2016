set input [list 1 13 10 19 2 3 1 7 3 5 5 17 0 11]

proc position {time start max} {
	return [expr ($time + $start) % $max]
}
set time -1
set j 0
while {$j < [expr [llength $input] / 2]} {
	incr time
	set j 0
	foreach {start max} $input {
		if {[position [expr $time + $j] $start $max]} {
			break
		}
		incr j
	}
}
puts [expr $time -1]
