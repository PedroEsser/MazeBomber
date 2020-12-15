extends StaticBody2D

var health

func _ready():
	self.set_scale(GlobalVariables.scale_vector)
	pass # Replace with function body.


func calculate_hp(distance_to_middle):
	health = distance_to_middle * 40 + Utils.uniform(20, 60)
	set_texture()
	pass

func set_texture():
	var n = 5 - floor(health*5/100)
	$Sprite.set_texture(load("res://World/images/parede_fase" + str(n) + ".png"))

	
