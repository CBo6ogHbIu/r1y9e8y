#include <MsgBoxConstants.au3>

global $approved = false
global $skipped  = false
global const $message_count = 6
global const $message[$message_count] = [ _
	"Select first DD window. <Alt+F3> - Approve, <ALt+F4> - Skip/Cancel", _
	"Select second DD window. <Alt+F3> - Approve, <ALt+F4> - Skip/Cancel", _
	"Select BD window. <Alt+F3> - Approve, <ALt+F4> - Skip/Cancel", _
	"Select SWS window. <Alt+F3> - Approve, <ALt+F4> - Skip/Cancel", _
	"Select WC window. <Alt+F3> - Approve, <ALt+F4> - Skip/Cancel", _
	"Select HEAL window. <Alt+F3> - Approve, <ALt+F4> - Skip/Cancel" _
]

func approve()
	$approved = true
endfunc

func skip()
	$skipped = true
endfunc

HotKeySet("!{F3}", "approve")
HotKeySet("!{F4}", "skip")

global $configured 			= false
global $handles_exists		= true

global $dd1_window_handle	= 0
global $dd2_window_handle	= 0
global $bd_window_handle	= 0
global $sws_window_handle	= 0
global $wc_window_handle	= 0
global $heal_window_handle	= 0

func config_windows()
	Local $i = 0

	; выбор окон
	while $configured == false
		ToolTip($message[$i])

		if $approved = true then

			Switch $i
				Case 0
					$dd1_window_handle 	= WinGetHandle("[TITLE:II]")
				Case 1
					$dd2_window_handle 	= WinGetHandle("[TITLE:II]")
				Case 2
					$bd_window_handle   = WinGetHandle("[TITLE:II]")
				Case 3
					$sws_window_handle  = WinGetHandle("[TITLE:II]")
				Case 4
					$wc_window_handle   = WinGetHandle("[TITLE:II]")
				Case 5
					$heal_window_handle = WinGetHandle("[TITLE:II]")
			EndSwitch

			$i = $i + 1
			$approved = false
		endif

		if $skipped = true then
			Switch $i
				Case 0
					$dd1_window_handle 	= 0
				Case 1
					$dd2_window_handle 	= 0
				Case 2
					$bd_window_handle   = 0
				Case 3
					$sws_window_handle  = 0
				Case 4
					$wc_window_handle   = 0
				Case 5
					$heal_window_handle = 0
			EndSwitch
			$i = $i + 1
			$skipped = false
		endif

		if $i == $message_count then
			$configured = true
			if $dd1_window_handle == 0 And $dd2_window_handle == 0 And $bd_window_handle == 0 and $sws_window_handle == 0 and $wc_window_handle == 0 and $heal_window_handle == 0 Then
				$handles_exists = false
				MsgBox( $MB_OK, "Error", "set_party_roles() - ERROR, all window handles are null")
				Exit
			EndIf
		endif

		Sleep(10)
	wend
endfunc
