#include <SendMessage.au3>
#include <WinAPIEx.au3>

Opt("SendKeyDownDelay", 10)
Opt("PixelCoordMode", 2)
Opt("MouseCoordMode", 2)

global const $error_coord 	= -1

func add_difference($delay)
	;	внесение погрешности в задержку
	;	значение погрешности +-20%
	return Random( $delay * 0.8, $delay * 1.2)
endfunc

func send_client($key, $delay)
	;	этот Send.. для зажатой клавиши. тут задержка может составлять около 20мс + ping.
	if $delay < 20 then
		$delay = 20
	endif
	Send($key, 0)
	Sleep(add_difference($delay))
endfunc

func is_pixel_exists($window_left, $window_right, $color)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 1)
	if not @error then
		return true
	else
		return false
	endif
endfunc

func is_pixel_exists_ex($window_left, $window_right, $color)
	local $ARGB = _WinAPI_IntToDWord(BitOR($color, 0xFF000000))
	local $area_size = ( $window_right[0] - $window_left[0] ) * ( $window_right[1] - $window_left[1] )
	local $tBits = DllStructCreate('dword[' & $area_size & ']')
	_WinAPI_GetBitmapBits($hBMP, 4 * $area_size, DllStructGetPtr($tBits))
	local $Timer = TimerInit()
	local $Offset = -1
	For $i = 1 To $area_size
		If DllStructGetData($tBits, 1, $i) = $ARGB Then
			$Offset = $i
			return true
			ExitLoop
		EndIf
	Next
	return false
endfunc

func is_pixels_changed($left, $right, byref $checksum)
	local $newsum = PixelChecksum($left[0], $left[1], $right[0], $right[1])

	if $newsum <> $checksum then
		$checksum = $newsum
		return true
	else
		return false
	endif
endfunc

func get_pixel_coords($window_left, $window_right, $color)
	local $coord = PixelSearch($window_right[0], $window_right[1], $window_left[0], $window_left[1], $color, 4)

	if not @error then
		return $coord
	else
		local $error[2] = [$error_coord, $error_coord]
		return $error
	endif
endfunc

Global $hBMP
Func get_pixel_color_ex($iX, $iY, $hWnd)
	Local $hDDC, $hCDC
	;	todo: Эту часть вытащить в общий цикл и вызывать как можно реже - раз в секунду, например
	;$iWidth = _WinAPI_GetWindowWidth($hWnd)
	$iWidth = _WinAPI_GetClientWidth($hWnd)
	;$iHeight = _WinAPI_GetWindowHeight($hWnd)
	$iHeight = _WinAPI_GetClientHeight($hWnd)
	$hDDC = _WinAPI_GetDC($hWnd)
	$hCDC = _WinAPI_CreateCompatibleDC($hDDC)
	$hBMP = _WinAPI_CreateCompatibleBitmap($hDDC, $iWidth, $iHeight)
	_WinAPI_SelectObject($hCDC, $hBMP)
	_WinAPI_PrintWindow($hWnd, $hCDC)


	$sColor = _WinAPI_GetPixel($hCDC, $iX, $iY)
	_WinAPI_ReleaseDC($hWnd, $hDDC)
	_WinAPI_DeleteDC($hCDC)
	Return $sColor
EndFunc   ;==>get_pixel_color_ex

;~ func get_actual_bitmap($hWnd)
;~ 	$iX = 500                 ; Вписать Х координату окна
;~ 	$iY = 250                 ; Вписать У координату окна
;~ 	; Учитывать то, что цвета у неактивного окна ДРУГИЕ, нежели у активного!
;~ 	MsgBox (0, "", "0x" & Hex(_PixelGetColorEx ($iX, $iY, $hWnd), 6 ))
;~ EndFunc	;==>get_actual_bitmap

func get_pixel_color($point)
	return PixelGetColor($point[0], $point[1])
endfunc

func get_bar_value($coord, $bar_left, $bar_right)
	local $result = ($coord[0] - $bar_left[0]) / ($bar_right[0] - $bar_left[0]) * 100
	return $result
endfunc