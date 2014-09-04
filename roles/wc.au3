;	управление
global const $wc_buff_timeout	= 1170
global const $wc_cov_timeout    = 290
global const $wc_fury_timeout   = 5

global const $wc_buff			= "{NUMPAD5}"
global const $wc_cov			= "{NUMPAD1}"
global const $wc_enlight		= "{NUMPAD6}"
global const $wc_attack			= "{1}"
global const $wc_fury			= "{2}"

func wc_attack()
	If $wc_window_handle <> 0 Then
		ControlSend($wc_window_handle, "", "", $wc_attack)
	EndIf
endfunc

func wc_fury()
	If $wc_window_handle <> 0 Then
		ControlSend($wc_window_handle, "", "", $wc_fury)
	EndIf
endfunc

func wc_cov()
	If $wc_window_handle <> 0 Then
		ControlSend($wc_window_handle, "", "", $wc_cov)
		Sleep(add_difference(500))
		wc_attack()
	EndIf
endfunc

func wc_buff()
	If $wc_window_handle <> 0 Then
		ControlSend($wc_window_handle, "", "", $wc_enlight)
		Sleep(add_difference(500))
		ControlSend($wc_window_handle, "", "", $wc_buff)
		Sleep(add_difference(25000))
		wc_attack()
	EndIf
endfunc
