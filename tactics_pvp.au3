#include "source/move.au3"
#include "source/search.au3"
#include "source/attack.au3"
#include "source/items.au3"

Func apply_tactics()
	if $ds_skills_auto_use == true Then
		$timeouts = "4.5,1.9,19.5,4.9"
		$handlers = "tyrant_self,dance_song,wc_buff,wc_cov"
	Else
		$timeouts = "4.5,2.5,19.5"
		$handlers = "tyrant_self,pw_self,wc_buff"
	EndIf
	apply_timeouts()
EndFunc

Func toggle_tactics()
	$ds_skills_auto_use = Not $ds_skills_auto_use
	apply_tactics()
EndFunc

Func main_loop()
	apply_tactics()
	wc_buff()
	wc_cov()
	dance_song()
	heal()
	pw_self()

	WinActivate($dd1_window_handle)
	tyrant_self()
	while true
		;	выписать время каждой функции
		check_alive()
		if $ds_skills_auto_use == true Then
			victim_search()
			move_to_target()
			pw_attack()
			attack_target()
			pick_drop(Random(3, 6, 1))
		Else
			pw_attack()
			attack_target()
		EndIf
	wend
EndFunc