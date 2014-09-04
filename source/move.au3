global const $kXCenter = 650
global const $kYCenter = 450

func move_to_target()

	if not is_target_for_attack() then
		return
	endif

	send_client($attack_target, add_difference(1500))

	local $timeout = 0
	while not is_target_for_attack()
		$timeout = $timeout + 1

		Sleep(500)

		if mod($timeout, 5) == 0 and not is_position_changed() then
			attack_timeout()
			return
		endif

		if mod($timeout, $move_timeout) == 0 then
			attack_timeout()
			return
		endif

		;next_target()
	wend
endfunc

func turn_right($offset)
	MouseMove($kXCenter, $kYCenter)
	MouseDown("right")
	MouseMove($kXCenter + $offset, $kYCenter)
	Sleep(400)
	MouseUp("right")
endfunc

func turn_left($offset)
	MouseMove($kXCenter, $kYCenter)
	MouseDown("right")
	MouseMove($kXCenter - $offset, $kYCenter)
	Sleep(400)
	MouseUp("right")
endfunc

func move_forward($delay)
	send_client("{" & $kWalkFrontKey & " down}", $delay)
	send_client("{" & $kWalkFrontKey & " up}", 0)
endfunc

func move_back($delay)
	send_client("{" & $kWalkBackKey & " down}", $delay)
	send_client("{" & $kWalkBackKey & " up}", 0)
endfunc

func random_move()
	MouseClick("left", Random(200, 600, 1), Random(300, 500, 1))
	Sleep(add_difference(4000))
endfunc

func look_around_and_move()

	turn_left(20)
	turn_right(40)
	turn_left(20)

	do
		turn_left(Random(4, 8))
		random_move()
	until is_position_changed()
endfunc