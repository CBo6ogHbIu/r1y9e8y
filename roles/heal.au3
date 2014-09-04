;	управление
global const $heal_timeout	= 60

global const $heal			= "{F6}"
global const $heal_attack	= "{1}"
global const $heal_party	= "{F2}"
global const $heal_battle	= "{F3}"
global const $heal_balance	= "{F4}"


func heal()
	if $heal_window_handle <> 0 Then
		ControlSend($heal_window_handle, "", "", $heal)
		Sleep(300)
		ControlSend($heal_window_handle, "", "", $heal_attack)
	EndIf
endfunc