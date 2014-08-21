Global Const $kEmptyColor = -1
Global Const $kBarFull = 95
Global Const $kBarHalf = 50
Global Const $kBarThird = 30
Global Const $kBarCritical = 20
Global $gMapChecksum = 0
Global $gTargetChecksum = 0

Func IsTargetExist()
	; Check target info window existance
;~ 	If IsPixelExistClient($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorBrown) Then
;~ 		If IsPixelExistClient($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorGray) Then
	If IsPixelExistClientEx($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorBrown) Then
		If IsPixelExistClientEx($kTargetWindowLeft, $kTargetWindowRight, $kTargetWindowColorGray) Then
			LogWrite("Target exist")
			Return True
		EndIf
	EndIf

	LogWrite("Target not exist")
EndFunc   ;==>IsTargetExist

Func IsTargetAlive()
	; Check to red color in target info
	If IsPixelExistClient($kTargetWindowLeft, $kTargetWindowRight, $kTargetHealthColor) Then
		LogWrite("Target alive")
		Return True
	Else
		LogWrite("Target not alive")
		Return False
	EndIf
EndFunc   ;==>IsTargetAlive

Func IsTargetPet()
	; Check to blue color in target info
	If IsPixelExistClient($kTargetManaLeft, $kTargetManaRight, $kTargetManaColor) _
			Or IsPixelExistClient($kTargetManaLeft, $kTargetManaRight, $kTargetManaEmptyColor) Then
		LogWrite("Target is pet")
		Return True
	Else
		LogWrite("Target is not pet")
		Return False
	EndIf
EndFunc   ;==>IsTargetPet

Func IsBarLess($left, $right, $color, $value)
	Local $coord = GetPixelCoordinateClient($left, $right, $color)
	Local $bar_value = GetBarValue($coord, $left, $right)

	If $bar_value < -10 Or $bar_value > 110 Then
		LogWrite("bar undefined!")
		Return False
	EndIf

	If $bar_value < $value Then
		LogWrite("bar < " & $value & "%")
		Return True
	Else
		LogWrite("bar > " & $value & "%")
		Return False
	EndIf
EndFunc   ;==>IsBarLess

Func IsHealthLess($value)
	LogWrite("IsHealthLess()")
	Return IsBarLess($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor, $value)
EndFunc   ;==>IsHealthLess

Func IsManaLess($value)
	LogWrite("IsManaLess()")
	Return IsBarLess($kSelfManaLeft, $kSelfManaRight, $kSelfManaColor, $value)
EndFunc   ;==>IsManaLess

Func IsTargetForAttack()
	If IsTargetExist() And IsTargetAlive() And Not IsTargetPet() Then
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>IsTargetForAttack

Func IsTargetDamaged()
	If Not IsTargetExist() Or Not IsTargetAlive() Then
		Return False
	EndIf

	LogWrite("IsTargetDamaged()")
	Return IsPixelsChanged($kTargetHealthLeft, $kTargetHealthRight, $gTargetChecksum)
EndFunc   ;==>IsTargetDamaged

Func IsPositionChanged()
	LogWrite("IsPositionChanged()")

	Return IsPixelsChanged($kMapWindowLeft, $kMapWindowRight, $gMapChecksum)
EndFunc   ;==>IsPositionChanged

Func check_alive()

	If IsHealthLess(3) Then
		LogWrite("	- player died")
		Exit
	Else
		LogWrite("	- player alive")
	EndIf
EndFunc   ;==>check_alive
