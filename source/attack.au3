global $gPrevHealth = 0

func IsHealthDecrease()
	local $coord = GetPixelCoordinateClient($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)

	if $coord[0] = $kErrorCoord then
		LogWrite("IsHealthDecrease() - health bar is not exist")
		return false
	endif

	LogWrite("IsHealthDecrease() - coord[0] = " & $coord[0] & " prev = " & $gPrevHealth)

	if $coord[0] < $gPrevHealth then
		LogWrite("IsHealthDecrease() - health is decrease")
		return true
	else
		LogWrite("IsHealthDecrease() - health is not decrease")
		return false
	endif
	$gPrevHealth = $coord[0]
endfunc

func UpdatePrevHealth()
	local $coord = GetPixelCoordinateClient($kSelfHealthLeft, $kSelfHealthRight, $kSelfHealthColor)

	if $coord <> false then
		$gPrevHealth = $coord[0]
	endif
endfunc

func Attack()
	if not IsTargetForAttack() then
		return
	endif

	UpdatePrevHealth()

	local $timeout = 0
	local $is_attacked = false
	while IsTargetAlive()
		$timeout = $timeout + 1

		OnCheckHealthAndMana()

		SendClient($kAttackKey, 500)

		if IsTargetDamaged() and not $is_attacked then
			OnAttack()
			$is_attacked = true
		endif

		if mod($timeout, $kAttackTimeout) == 0 and IsTargetForAttack() and not IsTargetDamaged() then
			LogWrite("Attack timeout")
			OnAttackTimeout()
		endif

		UpdatePrevHealth()
		check_alive()
	wend
endfunc