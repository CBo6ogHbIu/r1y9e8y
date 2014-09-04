#include <MsgBoxConstants.au3>

global const $tip_count = 19
global const $tips[$tip_count] = [ _
	"1. Укажите левую-верхнюю точку окна цели", _
	"2. Укажите правую-нижнюю точку окна цели", _
	"3. Укажите первую точку окна цели с характерным цветом", _
	"4. Укажите вторую точку окна цели с характерным цветом", _
	"5. Укажите левую-верхнюю точку на полоске HP цели", _
	"6. Укажите правую-нижнюю точку на полоске HP цели", _
	"7. Укажите точку на полной полоске HP цели с характерным цветом", _
	"8. Укажите левую-верхнюю точку на полоске MP цели (выделите себя)", _
	"9. Укажите правую-нижнюю точку на полоске MP цели (выделите себя)", _
	"10. Укажите точку на полной полоске MP цели с характерным цветом (выделите себя)", _
	"11. Укажите точку на пустой полоске MP цели с характерным цветом (выделите себя)", _
 	"12. Укажите левую-верхнюю точку на полоске HP игрока", _
 	"13. Укажите правую-нижнюю точку на полоске HP игрока", _
	"14. Укажите точку на полной полоске HP игрока с характерным цветом", _
	"15. Укажите левую-верхнюю точку на полоске MP игрока", _
	"16. Укажите правую-нижнюю точку на полоске MP игрока", _
	"17. Укажите точку на полной полоске MP игрока с характерным цветом", _
	"18. Укажите левую-верхнюю точку окна карты", _
	"19. Укажите правую-нижнюю точку окна карты" _
]

global const $param_names[$tip_count] = [ _
	"kTargetWindowLeft", _
	"kTargetWindowRight", _
	"kTargetWindowColorBrown", _
	"kTargetWindowColorGray", _
	"kTargetHealthLeft", _
 	"kTargetHealthRight", _
 	"kTargetHealthColor", _
 	"kTargetManaLeft", _
 	"kTargetManaRight", _
 	"kTargetManaColor", _
 	"kTargetManaEmptyColor", _
 	"kSelfHealthLeft", _
 	"kSelfHealthRight", _
 	"kSelfHealthColor", _
 	"kSelfManaLeft", _
 	"kSelfManaRight", _
 	"kSelfManaColor", _
	"kMapWindowLeft", _
	"kMapWindowRight" _
]

global $gTipIndex = 0
global $gIsSelect = false
global $gCoord[2] = [0, 0]
global $gColor = 0x000000

HotKeySet("!{F5}", "get_coords")

func get_coords()
	$gCoord = MouseGetPos()
	$gColor = PixelGetColor($gCoord[0], $gCoord[1])
	$gIsSelect = true
endfunc

func find_edge($step)
	$check_coord = $gCoord

	while $gCoord[0] <> 0 and $gColor == get_pixel_color($check_coord)
		$check_coord[0] = $check_coord[0] + $step
	wend

	return $check_coord[0]
endfunc

func write_point($param, $x, $y)
	FileWrite($config_file, "global const $" & $param & "[2] = [" & _
			  $x & "," & $y & "]" & chr(10))
endfunc

func write_color($param, $color)
	FileWrite($config_file, "global const $" & $param & " = 0x" & Hex($color, 6) & chr(10))
endfunc

func config_coords()
	If FileExists($config_file) Then
		Local $button_pressed = MsgBox($MB_YESNO, "Config file already exists", "Reconfig coords?", 10)
		If $button_pressed == $IDNO Then
			Return
		EndIf
	EndIf

	FileDelete($config_file)

	while true
		ToolTip($tips[$gTipIndex])

		if $gIsSelect = true then
			local $param = $param_names[$gTipIndex]

			if StringInStr($param, "Color") then
				write_color($param, $gColor)
			else
				write_point($param, $gCoord[0], $gCoord[1])
			endif

			$gTipIndex = $gTipIndex + 1
			$gIsSelect = false
		endif

		if $gTipIndex = $tip_count then
			ExitLoop
		endif

		Sleep(10)
	wend
EndFunc