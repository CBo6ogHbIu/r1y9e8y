#include "analysis.au3"
#include "timeout.au3"

func victim_search()

	while true

		check_hp_mp()
		check_timeouts()
		next_target()

		if is_target_for_attack() then
			exitloop
		else
			next_target_macro()

			if is_target_for_attack() then
				exitloop
			else
				send_client($cancel_target, 500)
			endif
		endif

	wend

endfunc
