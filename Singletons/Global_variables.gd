extends Node2D

const number_of_rays = 50
const pixel_art_scale = 16
const default_scale = 32
const default_width = 41
const default_height = 23

var my_width
var my_height
var my_scale
var scale_vector

func _init():
    set_dimensions(default_width, default_height)
    change_scale(default_scale)

func set_dimensions(w, h):
    my_width = w
    my_height = h

func change_scale(s):
    my_scale = s
    scale_vector = Vector2(s/pixel_art_scale, s/pixel_art_scale)
    pass