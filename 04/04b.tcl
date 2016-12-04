proc main {input} {
	foreach code $input {
		set code [split [string map {[ - ] {}} $code] "-"]
		set checksum [split [lindex $code end] {}]
		set sector [lindex $code end-1]
		set body [split [lrange $code 0 end-2] {}]

		if {![string match [get_checksum $body] $checksum]} {
			continue
		}

		set word {}
		foreach letter $body {
			append word [shift $letter $sector]
		}

		puts "$word $sector"
	}
}

proc get_checksum {text} {
	foreach letter [lsort $text] {
		if {[string match $letter { }]} {
			continue
		}
		dict incr counter $letter
	}
	dict map {key value} $counter {lappend checksum [list $key $value]}
	return [lrange [lmap letter [lsort -decreasing -integer -index 1 $checksum] {lindex $letter 0}] 0 4]
}

proc shift {letter shift} {
	set alpha {abcdefghijklmnopqrstuvwxyz}
	if {[string match $letter { }]} {
		return { }
	}

	set index [string first $letter $alpha]
	set shift [expr ($shift + $index) % 26]
	return [string index $alpha $shift]
}

main [split [read -nonewline stdin] "\n"]
