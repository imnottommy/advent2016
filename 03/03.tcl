proc main {triangles} {
	set possible 0
	foreach triangle $triangles {
		foreach {a b c} $triangle {
			if {[expr $a + $b] > $c && [expr $b + $c] > $a && [expr $a + $c] > $b} {
				incr possible
			}
		}
	}

	puts $possible
}

main [split [read -nonewline stdin] "\n"]
