package require md5 1.4.4

set password {{} {} {} {} {} {} {} {}}
set index 0
while {[lsearch $password {}] != -1} {
	set md5 [::md5::md5 "reyedfim${index}"]
	if {[string match [string range $md5 0 4] {00000}]} {
		set position [string index $md5 5]
		if {[string is integer $position] && $position < 8 && [string match [lindex $password $position] {}]} {
		lset password $position [string index $md5 6]
			puts "$index $password"
		}
	}

	#puts -nonewline ${index},
	incr index
}

puts $password
