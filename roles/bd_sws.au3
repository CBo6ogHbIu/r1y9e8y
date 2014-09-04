;	управление
global const $dance_song_timeout    = 114

global const $song					= "{F1}"
global const $dance					= "{F1}"
global const $bd_attack				= "{1}"
global const $sws_attack			= "{1}"
global const $shadow_dance	 		= "{NUMPAD1}"

func dance_song()
	If $sws_window_handle <> 0 Then
		ControlSend($sws_window_handle, "", "", $song)
		Sleep(8000)
		ControlSend($sws_window_handle, "", "", $sws_attack)
	EndIf
	If $bd_window_handle <> 0 Then
		ControlSend($bd_window_handle,  "", "", $dance)
	EndIf
endfunc

func shadow_dance()
	If $bd_window_handle <> 0 Then
		ControlSend($bd_window_handle,  "", "", $shadow_dance)
		Sleep(8000)
		ControlSend($bd_window_handle, "", "", $bd_attack)
	EndIf
 endfunc