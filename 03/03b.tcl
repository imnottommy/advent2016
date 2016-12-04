proc main {triangles} {
	set possible 0
	foreach t1 t2 t3 $triangles {
		foreach {a b c} [join [lmap a $t1 b $t2 c $t3 {list $a $b $c}]] {
			if {[expr $a + $b] > $c && [expr $b + $c] > $a && [expr $a + $c] > $b} {
				incr possible
			}
		}
	}

	puts $possible
}

main [split [read -nonewline stdin] "\n"]
