extends Node2D

var health = 100

func _draw():
	var bar_size = GlobalVariables.pixel_art_scale * .75
	var split_point = health * bar_size / 100
	self.draw_rect(Rect2(-bar_size/2, -GlobalVariables.pixel_art_scale * .3, split_point, 2), Color.green)
	self.draw_rect(Rect2(-bar_size/2 + split_point, -GlobalVariables.pixel_art_scale * .3, bar_size - split_point, 2), Color.red)

func set_hp(hp):
	health = hp
	update()

func get_hp():
	return health
