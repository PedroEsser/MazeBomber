extends Node2D

const power_ups = [
	"HPPowerUp",
	"SpeedPowerUp",
	"ShieldPowerUp",
	"MultipleTNTPowerUp",
	"BigBombPowerUp",
	"DamagePowerUp"
]

func get_random_power_up():
	var choice = Utils.diracs([0.45, 0.04, 0.02, 0.02, 0.02, 0.03, 0.42])
	if choice == 0:
		return null
	return power_ups[choice-1]
