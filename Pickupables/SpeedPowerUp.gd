extends Area2D

const player = preload("res://Player/Player.gd")

func pick_up(body):
	body.max_speed += 20

func _on_SpeedPowerUp_body_entered(body):
	if body is player:
		pick_up(body)
		queue_free()
