;	управление

global const $pw_attack_target 	= "{1}"
global const $pw_attack_skill_1 = "{Q}"
global const $pw_attack_skill_2 = "{E}"
global const $pw_attack_skill_3 = "{2}"
global const $pw_attack_skill_4 = "{3}"
global const $pw_attack_skill_5 = "{F3}"

global const $pw_selfbuff_1 	= "{NUMPAD9}"
global const $pw_selfbuff_2 	= "{NUMPAD0}"

func pw_attack()
	If $dd2_window_handle == 0 Then
		Return
	EndIf

	Local $skill = Random(1, 5, 1)
	Switch $skill
    Case 1
        ControlSend($dd2_window_handle, "", "", $pw_attack_skill_1)
    Case 2
        ControlSend($dd2_window_handle, "", "", $pw_attack_skill_2)
    Case 3
        ControlSend($dd2_window_handle, "", "", $pw_attack_skill_3)
    Case 4
        ControlSend($dd2_window_handle, "", "", $pw_attack_skill_4)
    Case 5
        ControlSend($dd2_window_handle, "", "", $pw_attack_skill_5)
   EndSwitch
   ControlSend($dd2_window_handle, "", "", $pw_attack_target)
endfunc

func pw_self()
	If $dd2_window_handle <> 0 Then
		ControlSend($dd2_window_handle, "", "", $pw_selfbuff_1)
		ControlSend($dd2_window_handle, "", "", $pw_selfbuff_2)
	EndIf
endfunc