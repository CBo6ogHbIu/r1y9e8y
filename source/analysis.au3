#include <MsgBoxConstants.au3>
global const $empty_color = -1
global const $bar_full = 95
global const $bar_half = 50
global const $bar_third = 25
global const $bar_critical = 15

global $map_checksum = 0
global $target_checksum = 0

func is_target_exist()
	; Check target info window existance
	if is_pixel_exists($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorBrown) then
		if is_pixel_exists($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorGray) then
			return true
		endif
	endif
endfunc

func is_target_alive()
	; Check to red color in target info
	if is_pixel_exists($kTargetWindowLeft, $kTargetWindowRight, $kTargetHealthColor) then
		return true
	else
		return false
	endif
endfunc

func is_target_pet()
	; Check to blue color in target info
	if is_pixel_exists($kTargetManaLeft, $kTargetManaRight, $kTargetManaColor) _
	or is_pixel_exists($kTargetManaLeft, $kTargetManaRight, $kTargetManaEmptyColor) then
		return true
	else
		return false
	endif
endfunc

func is_bar_less($left, $right, $color, $value)
	local $coord = get_pixel_coords($left, $right, $color)
	local $bar_value = get_bar_value($coord, $left, $right)

	;if $bar_value < -10 or $bar_value > 110 then
	if $bar_value > 110 then
		MsgBox( $MB_OK, "Error", "bar undefined!, value = " & $bar_value)
		return false
	endif

	if $bar_value < $value then
		return true
	else
		return false
	endif
endfunc

func is_health_less($value)
	return is_bar_less($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor, $value)
endfunc

func is_mana_less($value)
	return is_bar_less($kSelfManaLeft, $kSelfManaRight, $kSelfManaColor, $value)
endfunc

func is_target_for_attack()
	if is_target_exist() and is_target_alive() and not is_target_pet() then
		return true
	else
		return false
	endif
endfunc

func is_target_damaged()
	if not is_target_exist() or not is_target_alive() then
		return false
	endif
	return is_pixels_changed($kTargetHealthLeft, $kTargetHealthRight, $target_checksum)
endfunc

func is_position_changed()
	return is_pixels_changed($kMapWindowLeft, $kMapWindowRight, $map_checksum)
endfunc
global $negative_values_count = 0
func check_alive()
	if is_health_less(2) then
		$negative_values_count = $negative_values_count + 1
	Else
		$negative_values_count = 0
	Endif

	if $negative_values_count > 50 then
		MsgBox( $MB_OK, "OOOOPS", "	- player died")
		exit
	endif
endfunc