#include "analysis.au3"
#include "../conf/targets.au3"

func search_for_target()

	while true
		OnCheckHealthAndMana()

		NextTarget()

		if IsTargetForAttack() then
			exitloop
		else
			NextMacros()

			if IsTargetForAttack() then
				exitloop
			else
				SendClient($kCancelTarget, 500)
			endif
		endif


	wend
endfunc
