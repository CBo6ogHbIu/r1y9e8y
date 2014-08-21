global const $kTimeoutsArray = StringSplit($kTimeouts, ",")
global const $kHandlersArray = StringSplit($kTimeoutHandlers, ",")
global const $kTimeoutCount = $kTimeoutsArray[0]
global $gPrevTimes[$kTimeoutCount + 1]

for $i = 1 to $kTimeoutCount
	$gPrevTimes[$i] = TimerInit()
next

func ProcessTimeout($index, $timeout)

	local $time_diff = TimerDiff($gPrevTimes[$index])
	if $time_diff >= $timeout then
		LogWrite("	- call " & $kHandlersArray[$index])
		Call($kHandlersArray[$index])
		$gPrevTimes[$index] = TimerInit()
	endif
endfunc
