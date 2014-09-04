global const $config_file = "config/coords.au3"
global $ds_skills_auto_use 	= false

#include "global_hotkeys.au3"
#include "config/config_coords.au3"
#include "config/config_windows.au3"
#include "config/coords.au3"
#include "source/functions.au3"

#include "roles/tyrant.au3"
#include "roles/pw.au3"
#include "roles/wc.au3"
#include "roles/bd_sws.au3"
#include "roles/heal.au3"
#include "tactics.au3"

;	общее управление
global const $move_forward	= "UP"
global const $move_back 	= "DOWN"
global const $cancel_target = "{ESC}"

#requireadmin

wait_started()
config_windows()
config_coords()
main_loop()