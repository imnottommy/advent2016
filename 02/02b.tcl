# 2016-12-02

namespace eval ::keypad {
	variable position [dict create x 0 y 2]
	variable keypad [list {{} {} 1 {} {}} {{} 2 3 4 {}} {5 6 7 8 9} {{} A B C {}} {{} {} D {} {}}]
}

proc ::keypad::main {instructions} {
	foreach button [string tolower $instructions] {
		foreach command [split $button {}] {
			::keypad::$command [dict get $::keypad::position x] [dict get $::keypad::position y]
#			puts [dict get $::keypad::position x],[dict get $::keypad::position y]
		}
		puts [lindex [lindex $::keypad::keypad [dict get $::keypad::position y]] [dict get $::keypad::position x]]
	}
}

proc ::keypad::is_missing {x y} {
	return [string match {} [lindex [lindex $::keypad::keypad $y] $x]]
}

proc ::keypad::u {x y} { if {$y > 0 && ![::keypad::is_missing $x [expr $y -1]]} {dict incr ::keypad::position y -1} }
proc ::keypad::d {x y} { if {$y < 4 && ![::keypad::is_missing $x [expr $y +1]]} {dict incr ::keypad::position y +1} }
proc ::keypad::l {x y} { if {$x > 0 && ![::keypad::is_missing [expr $x -1] $y]} {dict incr ::keypad::position x -1} }
proc ::keypad::r {x y} { if {$x < 4 && ![::keypad::is_missing [expr $x +1] $y]} {dict incr ::keypad::position x +1} }

::keypad::main [split [read -nonewline stdin] "\n"]
