set registers [dict create a 0 b 0 c 1 d 0]
set cmds [split [read -nonewline stdin] "\n"]

set i 0
while {1} {
	if {$i > [llength $cmds]} {
		break
	}

	lassign [lindex $cmds $i] cmd r1 r2
	switch -- $cmd {
		inc { dict incr registers $r1 +1 }

		dec { dict incr registers $r1 -1 }

		cpy {
			if {[dict exists $registers $r1]} {
				dict set registers $r2 [dict get $registers $r1]
			} else {
				dict set registers $r2 $r1
			}
		}

		jnz {
			if {([dict exists $registers $r1] && [dict get $registers $r1] != 0) || (![dict exists $registers $r1] && $r1 != 0)} {
				incr i $r2
				continue
			}
		}
	}

	incr i
}

puts [dict get $registers a]
