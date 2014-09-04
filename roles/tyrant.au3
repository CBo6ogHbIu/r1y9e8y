;	управление

global const $next_target_key		= "{4}"
global const $next_macro_key_1		= "{6}"
global const $next_macro_key_2 		= "{7}"
global const $next_macro_key_3 		= "{8}"
global const $pickup_items			= "{5}"
global const $health_potion 		= "{F6}"
global const $mana_potion 			= "{F7}"

global const $attack_skill_timeout 	= 6
global const $attack_timeout 		= 20
global const $move_timeout 			= 40

global const $attack_target 		= "{1}"
global const $attack_skill_1 		= "{F2}"
global const $attack_skill_2 		= "{2}"
global const $attack_skill_3 		= "{3}"
global const $attack_skill_4 		= "{9}"
global const $attack_skill_5 		= "{F1}"

global const $selfbuff_1 			= "{F10}"
global const $selfbuff_2 			= "{F11}"

global const $limit1 				= "{F3}"
global const $limit2 				= "{F4}"

func attack()
	if($dd1_window_handle <> 0) Then
		Local $skill = Random(1, 5, 1)
		Switch $skill
			Case 1
				ControlSend($dd1_window_handle, "", "", $attack_skill_1)
			Case 2
				ControlSend($dd1_window_handle, "", "", $attack_skill_2)
			Case 3
				ControlSend($dd1_window_handle, "", "", $attack_skill_3)
			Case 4
				ControlSend($dd1_window_handle, "", "", $attack_skill_4)
			Case 5
				ControlSend($dd1_window_handle, "", "", $attack_skill_5)
		EndSwitch
		Sleep(1000)
	EndIf
endfunc

func turn_limits_on()
	If($dd1_window_handle <> 0) Then
		ControlSend($dd1_window_handle, "", "", $limit1)
		;ControlSend($dd1_window_handle, "", "", $limit2,  500)
	EndIf
endfunc

func next_target()
	If($dd1_window_handle <> 0) Then
		ControlSend($dd1_window_handle, "", "", $next_target_key)
		Sleep(1000)
	EndIf
endfunc

func next_target_macro()
	If($dd1_window_handle <> 0) Then
		Local $target = Random(0, 2, 1)
		Switch $target
			Case 0
				ControlSend($dd1_window_handle, "", "", $next_macro_key_1)
			Case 1
				ControlSend($dd1_window_handle, "", "", $next_macro_key_2)
			Case 2
				ControlSend($dd1_window_handle, "", "", $next_macro_key_3)
		EndSwitch
	EndIf
	Sleep(1000)
endfunc

func attack_timeout()
	If($dd1_window_handle <> 0) Then
		ControlSend($dd1_window_handle, "", "", $cancel_target)
		look_around_and_move()
	EndIf
endfunc

func tyrant_self()
	If($dd1_window_handle <> 0) Then
		ControlSend($dd1_window_handle, "", "", $selfbuff_1)
		ControlSend($dd1_window_handle, "", "", $selfbuff_2)
	EndIf
endfunc

func check_hp_mp()
	If($dd1_window_handle <> 0) Then
		if is_health_less($bar_third) then
			turn_limits_on()
		endif

		if is_health_less($bar_half) then
			if $heal_window_handle <> 0 Then
				heal()
			Else
				health_potion()
			EndIf
		endif

		if is_mana_less($bar_third) then
			mana_potion()
		endif
	EndIf
endfunc