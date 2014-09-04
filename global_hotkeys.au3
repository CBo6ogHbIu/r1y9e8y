HotKeySet("!{F1}", 		"on_exit")
HotKeySet("!{F2}", 		"on_start")
HotKeySet("{PAUSE}", 	"on_pause")
HotKeySet("!{F12}",		"toggle_tactics")
HotKeySet("!{F9}", 		"dance_song")
HotKeySet("!{F10}",		"wc_cov")
HotKeySet("!{F11}",		"heal")

global $is_started		= false
Global $is_paused		= false

func on_exit()
    exit
endfunc

func on_start()
    $is_started = true
endfunc

func on_pause()
    $is_paused = not $is_paused
    while $is_paused
        sleep(20)
    wEnd
endfunc

func wait_started()
	while not $is_started
		Sleep(500)
	wend
endfunc