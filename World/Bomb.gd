extends StaticBody2D

onready var animationBomb = $AnimationPlayer
var timestamp
var lifetime

func _process(delta):
	var time_ellapsed = OS.get_ticks_msec() - timestamp
	if time_ellapsed > lifetime:  
		animationBomb.play("Explosion")
		yield(animationBomb, "animation_finished")
		self.queue_free()
	else:
		animationBomb.set_speed_scale(0.5 + 1.2*time_ellapsed/2000)
	
func _init():
	lifetime = ((randf()*1000)+1500)
	timestamp = OS.get_ticks_msec()
	
