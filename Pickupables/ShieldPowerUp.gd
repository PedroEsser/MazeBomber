extends Area2D

const player = preload("res://Player/Player.gd")

func _ready():
	pass

func pick_up(body):
	pass

func _on_Power_up_body_entered(body):
	if body is player:
		pick_up(body)
		queue_free()


func _on_ShieldPowerUp_body_entered(body):
	pass # Replace with function body.
