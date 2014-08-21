#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "../source/hooks.au3"
#include "../conf/interface.au3"
#include "../conf/control.au3"
#include "../source/debug.au3"
#include "../source/functions.au3"
#include "../source/move.au3"
#include "../source/search.au3"
#include "../source/attack.au3"
#include "../source/items.au3"
#include "../source/timeout.au3"

global $windows_are_ready = false
global $dd_window_handle
global $bd_window_handle
global $wc_window_handle

func selfbuff()
	WinActivate($dd_window_handle)
	SendClient($kSelfBuff1, 800)
	SendClient($kSelfBuff2, 800)
endfunc

func dance()
	WinActivate($bd_window_handle)
	SendClient($kDance, 4000)
	WinActivate($dd_window_handle)
endfunc

func buff()
	WinActivate($wc_window_handle)
	SendClient($kBuff, 800)
	WinActivate($dd_window_handle)
endfunc

func COV()
	;WinActivate($wc_window_handle)
	;SendClient($kCOV, 800)
	;WinActivate($dd_window_handle)
endfunc

;	запуск окон строго в порядке: вк->бд->дд   (стек). поэтому нумерация будет: дд - 1, бд - 2, вк - 37667
func get_window_list($mask)

	if $windows_are_ready == true then
		return
	endif

	local $aList = WinList($mask)

	if $aList[0][0] <> 0 then
		;For $i = 1 To $aList[0][0]
		;	If $aList[$i][0] <> "" And BitAND(WinGetState($aList[$i][1]), 2) Then
		;		MsgBox($MB_SYSTEMMODAL, "", "Title: " & $aList[$i][0] & @CRLF & "Handle: " & $aList[$i][1])
		;	EndIf
		;Next

		$windows_are_ready = true
		$dd_window_handle = $aList[1][1]
		$bd_window_handle = $aList[2][1]
		;$wc_window_handle = $aList[3][1]
		LogWrite("get_window_list() - OK")
	else
		$windows_are_ready = false
		LogWrite("get_window_list() - ERROR, win_count=" & $aList[0][0])
	endif
endfunc

func check_timeouts()
	for $i = 1 to $kTimeoutCount
		ProcessTimeout($i, $kTimeoutsArray[$i] * $kMinute)
	next
endfunc

; Main Loop
while true
	get_window_list("[TITLE:II]")

	WinActivate($dd_window_handle)
	check_alive()
	search_for_target()
	move_to_target()
	attack()
	OnAllKill()
	check_timeouts()

wend
