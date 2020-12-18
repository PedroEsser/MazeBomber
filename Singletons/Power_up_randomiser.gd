extends Node2D

const power_ups = [
	"HPPowerUp",
	"SpeedPowerUp",
	"ShieldPowerUp",
	"MultipleTNTPowerUp",
	"BigBombPowerUp"
]

func get_random_power_up():
	var choice = Utils.diracs([0.85, 0.05, 0.025, 0.025, 0.02, 0.03])
	if choice == 0:
		return null
	return power_ups[choice-1]
