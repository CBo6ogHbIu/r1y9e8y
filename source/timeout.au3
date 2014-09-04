global const $minute 		= 60 * 1000
global $timeouts
global $handlers
global $timeouts_temp		= StringSplit($timeouts, ",")
global $handlers_temp		= StringSplit($handlers, ",")
global $timeouts_count		= $timeouts_temp[0]
global $previous_time[$timeouts_count + 12]

Func apply_timeouts()
	$timeouts_temp 	= StringSplit($timeouts, ",")
	$handlers_temp 	= StringSplit($handlers, ",")
	$timeouts_count = $timeouts_temp[0]
	for $i = 1 to $timeouts_count
		$previous_time[$i] = TimerInit()
	next
EndFunc

func check_timeouts()
	local $time_diff = 0
	for $i = 1 to $timeouts_count
		$time_diff = TimerDiff($previous_time[$i])
		if $time_diff >= $timeouts_temp[$i] * $minute then
			Call($handlers_temp[$i])
			$previous_time[$i] = TimerInit()
		endif
	Next
endfunc
