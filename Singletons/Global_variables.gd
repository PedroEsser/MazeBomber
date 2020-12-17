extends Node2D

const number_of_rays = 128
const pixel_art_scale = 16
const default_scale = 32
const default_width = 41
const default_height = 23

var my_width
var my_height
var my_scale
var scale_vector
var offset

func _init():
	change_scale(default_scale)

func change_scale(s):
	my_scale = s
	scale_vector = Vector2(s/pixel_art_scale, s/pixel_art_scale)
	var screen_dimensions = OS.get_real_window_size()
	var maze_dimensions = screen_dimensions / my_scale
	my_width = int(maze_dimensions.x)
	my_height = int(maze_dimensions.y)
	if my_width % 2 == 0:
		my_width -= 1
	if my_height % 2 == 0:
		my_height -= 1
	offset = (screen_dimensions - Vector2(my_width, my_height) * my_scale)/2
