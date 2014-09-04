func pick_drop($count)
	for $i = 0 to $count step 1
		send_client($pickup_items, add_difference(600))
	next
endfunc

func health_potion()
	send_client($health_potion, add_difference(200))
endfunc

func mana_potion()
	send_client($mana_potion, add_difference(200))
endfunc
