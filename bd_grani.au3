#include "source/functions.au3"
#include "config/config_windows.au3"
#include "global_hotkeys.au3"

global const $timeouts	= "1.9"
global const $handlers	= "shadow_dance"

#include "source/timeout.au3"
#include "roles/bd_sws.au3"


#requireadmin

wait_started()
config_windows()
while True
	check_timeouts()
	Sleep(1000)
WEnd
