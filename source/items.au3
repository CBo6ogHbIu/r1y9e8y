func PickDrop($count)
	for $i = 0 to $count step 1
		SendClient($kPickDropKey, addDifference(600))
	next
endfunc

func HealthPotion()
	LogWrite("HealthPotion()")
	SendClient($kHeathPoitionKey, addDifference(500))
endfunc

func ManaPotion()
	LogWrite("ManaPotion()")
	SendClient($kManaPoitionKey, addDifference(500))
endfunc
