extends StaticBody2D

#onready var animationBomb = $AnimationPlayer
const wall = preload("Wall.gd")
var player = load("res://Player/Player.gd")
const mask = 0xfffffffd
const base_damage = 400
const base_radius = 10
var time_ellapsed = 0
var lifetime
var damage
var radius
var exploding = false

func _process(delta):
	if exploding:
		#animationBomb.play("Explosion")
		#yield(animationBomb, "animation_finished")
		self.queue_free()
	else:
		time_ellapsed += delta
		#animationBomb.set_speed_scale(0.5 + .6*time_ellapsed)
		exploding = time_ellapsed > lifetime
		if exploding:
			doExplosion()

func my_init(owner):
	self.set_scale(GlobalVariables.scale_vector)
	lifetime = Utils.uniform(2000, 3000)/1000
	damage = base_damage + owner.extra_damage * 2
	damage = Utils.normal(damage, 30, damage-100, damage+100)
	radius = base_radius + owner.extra_radius * 2
	
func doExplosion():
	var ds = get_world_2d().get_direct_space_state()
	var n = GlobalVariables.number_of_rays
	var damage_per_ray = damage/n
	for i in range(n):
		var collision = ds.intersect_ray(self.position, self.position + Vector2(cos(TAU*i/n), sin(TAU*i/n)) * GlobalVariables.my_scale * radius, [self], mask)
		if collision != null && !collision.empty():
			var collider = collision.get("collider")
			if collider is wall || collider is player:
				collider.take_damage(damage_per_ray)

