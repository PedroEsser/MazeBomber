extends StaticBody2D

onready var animationBomb = $AnimationPlayer
var timestamp
var lifetime
var exploding = false

func _process(_delta):
	if exploding:
		animationBomb.play("Explosion")
		yield(animationBomb, "animation_finished")
		self.queue_free()
	else:
		var time_ellapsed = OS.get_ticks_msec() - timestamp
		animationBomb.set_speed_scale(0.5 + 1.2*time_ellapsed/2000)
		exploding = time_ellapsed > lifetime
		#if exploding:
		#	doExplosion()

func _init():
	self.set_scale(GlobalVariables.scale_vector)
	lifetime = ((randf()*1000)+1500)
	timestamp = OS.get_ticks_msec()
	
func doExplosion():
	var ds = get_world_2d().get_direct_space_state()
	print(ds.intersect_ray(self.position, self.position + Vector2(GlobalVariables.pixel_art_scale, 0)))

func _draw():
	#draw_rays(50)
	pass

func draw_rays(n):
	for i in range(n):
		draw_line(Vector2.ZERO, Vector2(cos(TAU*i/n), sin(TAU*i/n)) * GlobalVariables.pixel_art_scale * 5, Color.red)

func destroy_walls_around_test(r):
	var start_x = floor(self.position.x / GlobalVariables.my_scale) - r
	var start_y = floor(self.position.y / GlobalVariables.my_scale) - r
	var end_x = start_x + 2 * r + 1
	var end_y = start_y + 2 * r + 1
	for i in range(start_x, end_x, 1):
		for j in range(start_y, end_y, 1):
			var wall = MapData.get_wall_at(j, i)
			if wall:
				wall.queue_free()
