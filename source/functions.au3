#include <SendMessage.au3>

WaitGrabCommand()

Sleep(200)

Opt("SendKeyDownDelay", 10)
Opt("PixelCoordMode", 2)
Opt("MouseCoordMode", 2)

global const $kMinute = 60 * 1000
global const $kErrorCoord = -1
global const $kToggleCount = 12
global $gToggleList[$kToggleCount]

func WaitGrabCommand()
	while not $gIsGrab
		Sleep(1)
	wend
endfunc

func addDifference($delay)
	;	внесение погрешности в задержку
	;	значение погрешности +-20%
	return Random( $delay * 0.8, $delay * 1.2)
endfunc

func SendClient($key, $delay)
	;	этот Send.. для зажатой клавиши. тут задержка может составлять около 20мс + ping.
	if $delay < 20 then
		$delay = 20
	endif
	LogWrite("SendClient() - " & $key)
	ControlSend($dd_window_handle, "", "", $key)
	Sleep(addDifference($delay))
endfunc

func SendSymbolClient($key, $delay)
	;	этот Send.. для ввода правильного английского текста
	;	скорость ввода около 2символов/сек = 500мс/символ + погрешность + ping
	if $delay < 500 then
		$delay = 500
	endif
	LogWrite("SendSymbolClient() - " & $key)
	Send($key, 1)
	Sleep(addDifference($delay))
endfunc

func SendSplitText($text)
	local $key_array = StringSplit($text, "")

	for $i = 1 to $key_array[0] step 1
		if $key_array[$i] == "!" or $key_array[$i] == "/" then
			Send($key_array[$i], 1)
		else
			Send($key_array[$i])
		endif
		Sleep(addDifference(500))
	next
	Sleep(addDifference(200))
endfunc

func SendTextClient($text)
	LogWrite("SendTextClient() - " & $text)

	Send($kEnterKey)
	Sleep(200)

	SendSplitText($text)

	Send($kEnterKey)
	Sleep(500)
endfunc

func IsPixelExistClient($window_left, $window_right, $color)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 1)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func IsPixelsChanged($left, $right, byref $checksum)
	LogWrite("IsPixelsChanged()")

	local $newsum = PixelChecksum($left[0], $left[1], $right[0], $right[1])

	if $newsum <> $checksum then
		LogWrite("	- changed new checksum = " & $newsum & " old checksum = " & $checksum)
		$checksum = $newsum
		return true
	else
		LogWrite("	- same checksum = " & $newsum)
		return false
	endif
endfunc

func GetPixelCoordinateClient($window_left, $window_right, $color)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 4)

	if not @error then
		return $coord
	else
		local $error[2] = [$kErrorCoord, $kErrorCoord]
		return $error
	endif
endfunc

func GetPixelColorClient($point)
	return PixelGetColor($point[0], $point[1])
endfunc

func MouseClickClient($botton, $x, $y)
	LogWrite("MouseClickClient() - " & $botton & " x = " & $x & " y = " & $y)
	MouseClick($botton, $x, $y)
endfunc

func GetBarValue($coord, $bar_left, $bar_right)
	local $result = ($coord[0] - $bar_left[0]) / ($bar_right[0] - $bar_left[0]) * 100

	LogWrite("GetBarValue() - result = " & Round($result, 2) & "%")

	return $result
endfunc

func SwitchToggle($number, $key, $state)
	LogWrite("SwitchToggle() - number = " & $number & " key = " & $key & " state = " & $state)

	if $kToggleCount <= $number then
		return
	endif

	if $gToggleList[$number] == $state then
		return
	endif

	SendClient($key, 1000)
	$gToggleList[$number] = $state
endfunc
