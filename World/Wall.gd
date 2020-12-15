extends StaticBody2D

var health
var border = false

func _ready():
	self.set_scale(GlobalVariables.scale_vector)
	pass

func set_border():
	border = true

func calculate_hp(distance_to_middle):
	health = distance_to_middle * 40 + Utils.uniform(20, 60)
	set_texture()
	pass

func take_damage(damage):
	if !border:
		if health < damage:
			queue_free()
			return
		health -= damage
		set_texture()

func set_texture():
	if !border:
		var n = 4 - floor(health*4/100)
		$Sprite.set_texture(load("res://World/images/parede_fase" + str(n) + ".png"))

	
