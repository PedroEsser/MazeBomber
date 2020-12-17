extends Area2D

const player = preload("res://Player/Player.gd")
var receiver

func pick_up(body):
	receiver = body
	receiver.max_speed += 60
	var timer = Timer.new()
	add_child(timer)
	timer.autostart = false
	timer.connect("timeout", self, "speed_down")
	timer.wait_time = 8

func speed_down():
	receiver.max_speed -= 60

func _on_SpeedPowerUp_body_entered(body):
	if body is player:
		pick_up(body)
		queue_free()
