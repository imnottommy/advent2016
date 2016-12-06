proc main {input} {
	set length [string length [lindex $input 0]]
	for {set i 0} {$i < $length} {incr i} {
		set counter [dict create]
		foreach str $input {
			dict incr counter [string index $str $i]
		}
		puts [lindex [lsort -decreasing -integer -stride 2 -index 1 $counter] 0]
	}
}

main [split [read -nonewline stdin] "\n"]
