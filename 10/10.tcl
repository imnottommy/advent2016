set input [split [read -nonewline stdin] "\n"]

set rules [dict create]
set values [dict create]
proc move {value to from} {
	global values rules

	dict lappend values $to $value
	remove $value $from

	return 1
}

proc remove {value from} {
	global values rules

	set holding [dict get $values $from]
	set idx [lsearch -exact $holding $value]
	dict set values $from [lreplace $holding $idx $idx]
}

foreach line $input {
	switch -glob $line {
		bot* {
			regexp {^(\w+?) (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)$} $line -> type bot ltype low htype high
			dict set rules $type$bot [dict create {low} "$ltype$low" {high} "$htype$high"]
		}

		value* {
			regexp {^value (\d+) goes to (bot) (\d+)$} $line -> value type bot
			dict lappend values $type$bot $value
		}
	}
}

set done 0
while {!$done} {
	set done 1
	foreach key [lsort -increasing [dict keys $values]] {
		set value [dict get $values $key]
		if {![string match $key "output*"]} {
			if {[llength $value] == 2} {
				set done 0
				lassign [lsort -increasing -integer $value] a b
				move $a [dict get $rules $key {low}] $key
				move $b [dict get $rules $key {high}] $key
				puts "$key move $a to [dict get $rules $key {low}] and $b to [dict get $rules $key {high}]"
			}
		}
	}
}

puts [expr [dict get $values {output0}] * [dict get $values {output1}] * [dict get $values {output2}]]

