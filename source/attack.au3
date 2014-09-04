global $previous_health = 0

func is_health_decrease()
	local $coord = get_pixel_coords($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)

	if $coord[0] = $kErrorCoord then
		return false
	endif

	if $coord[0] < $previous_health then
		return true
	else
		return false
	endif
	$previous_health = $coord[0]
endfunc

func upddate_prev_health()
	local $coord = get_pixel_coords($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)

	if $coord <> false then
		$previous_health = $coord[0]
	endif
endfunc

func attack_target()
	if not is_target_for_attack() then
		return
	endif

	local $timeout = 0
	local $is_attacked = false

	while is_target_alive()
		$timeout = $timeout + 1

		send_client($attack_target, 1000)

		if is_target_damaged() and not $is_attacked then
			attack()
			$is_attacked = true
		endif

		if mod($timeout, $attack_timeout) == 0 and is_target_for_attack() and not is_target_damaged() then
			attack_timeout()
		endif

		upddate_prev_health()
		check_hp_mp()
		check_alive()
	wend
endfunc