set max 100
proc d2b {decimal} {
	binary scan [binary format {I} $decimal] {B*} binary

	return $binary
}

proc iswall {x y {code {1362}}} {
	if {$x < 0 || $y < 0} {
		return 1
	}

	if {![info exists map($x,$y)]} {
		set map($x,$y) [expr [llength [lsearch -inline -all [split [d2b [expr ($x*$x + 3*$x + 2*$x*$y + $y + $y*$y) + $code]] {}] {1}]] % 2]
	}

	return $map($x,$y)
}

proc valid_moves {x y moves} {
	global max
	if {$x == 31 && $y == 39} {
		puts [expr [llength $moves] -1]
	}

	if {[llength $moves] < $max} {
		foreach move [list [list $x [expr $y+1]] [list $x [expr $y-1]] [list [expr $x+1] $y] [list [expr $x-1] $y]] {
			if {![iswall {*}$move] && [lsearch $moves $move] == -1} {
				valid_moves {*}$move [list {*}$moves $move]
			}
		}
	}
}

valid_moves 1 1 [list {1 1}]
