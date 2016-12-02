# 2016-12-02

namespace eval ::keypad {
	variable position [dict create x 1 y 1]
	variable keypad [list {1 2 3} {4 5 6} {7 8 9}]
}

proc ::keypad::main {instructions} {
	foreach button [string tolower $instructions] {
		foreach command [split $button {}] {
			::keypad::$command
		}
		puts [lindex [lindex $::keypad::keypad [dict get $::keypad::position x]] [dict get $::keypad::position y]]
	}
}

proc ::keypad::u {} { if {[dict get $::keypad::position x] > 0} {dict incr ::keypad::position x -1} }
proc ::keypad::d {} { if {[dict get $::keypad::position x] < 2} {dict incr ::keypad::position x +1} }
proc ::keypad::l {} { if {[dict get $::keypad::position y] > 0} {dict incr ::keypad::position y -1} }
proc ::keypad::r {} { if {[dict get $::keypad::position y] < 2} {dict incr ::keypad::position y +1} }

::keypad::main [split [read -nonewline stdin] "\n"]
