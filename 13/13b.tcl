proc dec2bin i {
    set res {} 
    while {$i>0} {
        set res [expr {$i%2}]$res
        set i [expr {$i/2}]
    }
    if {$res == {}} {set res 0}
    return $res
}

proc iswall {x y} {
	if {$x < 0 || $y < 0} {
		return 1
	}

	set input 1362
	if {![info exists map($x,$y)]} {
		set map($x,$y) [expr [llength [lsearch -inline -all [split [dec2bin [expr ($x*$x + 3*$x + 2*$x*$y + $y + $y*$y) + $input]] {}] {1}]] % 2]
#		puts [dec2bin [expr ($x*$x + 3*$x + 2*$x*$y + $y + $y*$y) + $input]]
#		puts [expr ($x*$x + 3*$x + 2*$x*$y + $y + $y*$y) + $input]
	}

	return $map($x,$y)
}

global all_moves

set all_moves [list {1 1}]
proc print {moves} {
global what
	foreach move $moves {
		lassign $move x y
		set what($x,$y) 0
	}

	for {set i 0} {$i < 80} {incr i} {
		for {set j 0} {$j < 100} {incr j} {
			set x {.}
			if {[iswall $j $i]} {
				set x {#}
			}
			if {[info exists what($j,$i)]} {
				set x 0
			}		
			puts -nonewline "$x "
		}
		puts -nonewline "\n"
	}

}


proc valid_moves {x y moves} {
	global all_moves
	set original $moves
	if {[llength $moves] < 51} {
		foreach move [list [list $x [expr $y+1]] [list $x [expr $y-1]] [list [expr $x+1] $y] [list [expr $x-1] $y]] {
			set moves $original
			if {![iswall {*}$move]} {
				if {[lsearch $moves $move] == -1} {
					if {[lsearch $all_moves $move] == -1} {
						lappend all_moves $move
					}
					lappend moves $move
					valid_moves {*}$move $moves
				}
			}
		}
	}
}

valid_moves 1 1 [list {1 1}]
puts [llength $all_moves]
print $all_moves
