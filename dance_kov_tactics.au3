#include "source/move.au3"
#include "source/search.au3"
#include "source/attack.au3"
#include "source/items.au3"

Func apply_tactics()
	$timeouts = "1.9,19.5,4.9"
	$handlers = "dance_song,wc_buff,wc_cov"
	apply_timeouts()
EndFunc

Func main_loop()
	apply_tactics()
	wc_buff()
	wc_cov()
	dance_song()

	while true
		check_alive()
	wend
EndFunc