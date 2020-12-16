extends Node2D

const shield = preload("Shield_power_up.gd")

func get_random_power_up():
	return shield.new()
