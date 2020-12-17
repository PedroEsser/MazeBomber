extends Area2D

var spawner
const player = preload("res://Player/Player.gd")

func my_init(s):
	spawner = s

func pick_up(body):
	body.number_of_bombs += 1
	spawner.start_timer()

func _on_BoomBox_body_entered(body):
	if body is player:
		pick_up(body)
		queue_free()

