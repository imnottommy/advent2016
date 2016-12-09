package require md5 1.4.4

set password {}
set index 0
while {[llength $password] < 8} {
	set md5 [::md5::md5 "reyedfim${index}"]
	if {[string match [string range $md5 0 4] {00000}]} {
		lappend password [string index $md5 5]
		puts $password
	}

	#puts -nonewline ${index},
	incr index
}

puts $password
