set input {01111010110010011}

proc copy {str} {
	set str [split $str {}]
	set copy [lreverse $str]
	foreach letter $copy {
		switch $letter {
			0 { lappend final {1} }
			1 { lappend final {0} }
		}

	}

	return [join $str {}]0[join $final {}]
}

proc generate {str length} {
	while {[string length $str] < $length} {
		set str [copy $str]
	}

	return [string range $str 0 $length-1]
}

proc checksum {str} {

	foreach {a b} [split $str {}] {
		if {[string match $a $b]} {
			lappend result 1
		} else {
			lappend result 0
		}
	}

	return [join $result {}]
}

proc gen_checksum {str} {
	while {[expr [string length [set str [checksum $str]]] % 2] == 0} {
	}

	return $str
}


puts [gen_checksum [generate $input [lindex $::argv 0]]]
