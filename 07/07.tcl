proc is_abba {str} {
	if {[string equal [string index $str 0] [string index $str 1]]} {
		return 0
	}


	return [string equal -length 2 $str [string reverse $str]]
}

proc has_abba {str} {
	for {set i 0} {$i < [expr [string length $str] -3]} {incr i} {
		if {[is_abba [string range $str $i [expr $i + 3]]]} {
			return 1
		}
	}

	return 0
}

proc has_valid_hypernet {str} {
	foreach hypernet [regexp -all -inline -- {\[.+?\]} $str] {
		if {[has_abba $hypernet]} {
			return 0
		}
	}

	return 1
}

foreach ip [split [read -nonewline stdin] "\n"] {
	if {![has_valid_hypernet $ip]} {
		continue
	}

	foreach str [regsub -all -- {\[.+?\]} $ip { }] {
		if {[has_abba $str]} {
			puts $ip
			break
		}
	}
}
