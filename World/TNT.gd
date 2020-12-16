extends StaticBody2D

onready var animationBomb = $AnimationPlayer
const wall = preload("Wall.gd")
const mask = 0xfffffffd
const base_damage = 200
const base_radius = 6
var timestamp
var lifetime
var damage
var radius = 8
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
		if exploding:
			doExplosion()

func my_init(extra_damage, extra_radius):
	self.set_scale(GlobalVariables.scale_vector)
	lifetime = ((randf()*1000)+1500)
	timestamp = OS.get_ticks_msec()
	damage = base_damage + extra_damage
	damage = Utils.normal(damage, 30, damage-100, damage+100)
	radius = base_radius + extra_radius
	
func doExplosion():
	var ds = get_world_2d().get_direct_space_state()
	var n = GlobalVariables.number_of_rays
	for i in range(n):
		var collision = ds.intersect_ray(self.position, self.position + Vector2(cos(TAU*i/n), sin(TAU*i/n)) * GlobalVariables.pixel_art_scale * radius, [self], mask)
		if collision != null:
			var collider = collision.get("collider")
			if collider is wall:
				collider.take_damage(damage/n)

func _draw():
	#draw_rays(50)
	pass

func draw_rays(n):
	for i in range(n):
		draw_line(Vector2.ZERO, Vector2(cos(TAU*i/n), sin(TAU*i/n)) * GlobalVariables.pixel_art_scale * radius, Color.red)

