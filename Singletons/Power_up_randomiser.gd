extends Node2D

const power_ups = [
	"ShieldPowerUp",
	"BigBombPowerUp",
	"HPPowerUp",
	"SpeedPowerUp",
	"MultipleTNTPowerUp"
]

func get_random_power_up():
	var choice = Utils.diracs([0.1, 0.8, 0.025, 0.025, 0.025, 0.025])
	if choice == 0:
		return null
	return power_ups[choice-1]
