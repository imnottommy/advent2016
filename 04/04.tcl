proc main {input} {
	set sum 0
	foreach code $input {
		set code [split [string map {[ - ] {}} $code] "-"]
		set checksum [split [lindex $code end] {}]
		set sector [lindex $code end-1]
		set body [lsort [split [string map {{ } {}} [lrange $code 0 end-2]] {}]]

		if {[string match [get_checksum $body] $checksum]} {
			incr sum $sector
		}
	}

	puts $sum
}

proc get_checksum {text} {
	foreach letter $text {
		dict incr counter $letter
	}
	dict map {key value} $counter {lappend checksum [list $key $value]}
	return [lrange [lmap letter [lsort -decreasing -integer -index 1 $checksum] {lindex $letter 0}] 0 4]
}

main [split [read -nonewline stdin] "\n"]
