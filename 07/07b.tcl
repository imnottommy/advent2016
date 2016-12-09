proc is_aba {str} {
	if {[string equal [string index $str 0] [string index $str 1]]} {
		return 0
	}

	return [string equal [string index $str 0] [string index $str 2]]
}

proc get_aba {str} {
	set aba {}
	for {set i 0} {$i < [expr [string length $str] -2]} {incr i} {
		set sub [string range $str $i [expr $i + 2]]
		if {[is_aba $sub]} {
			lappend aba $sub
		}
	}

	return $aba
}

proc has_valid_hypernet {str aba_list} {
	foreach aba $aba_list {
		set bab [string index $aba 1][string index $aba 0][string index $aba 1]
		foreach hypernet [regexp -all -inline -- {\[.+?\]} $str] {
			if {[string match "*$bab*" $hypernet]} {
				return 1
			}
		}
	}

	return 0
}

foreach ip [split [read -nonewline stdin] "\n"] {
	set aba {}
	foreach str [regsub -all -- {\[.+?\]} $ip { }] {
		if {[llength [set aba_list [get_aba $str]]]} {
			lappend aba {*}$aba_list
		}
	}

	if {[has_valid_hypernet $ip $aba]} {
		puts $ip
	}
}
