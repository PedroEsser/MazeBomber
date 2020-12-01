extends Node2D

const default_scale = 16
var my_scale
var scale_vector
var maze
var node_holder


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	my_init(31, 13, 32)

func my_init(w, h, s):
	my_scale = s
	scale_vector = Vector2(s/default_scale, s/default_scale)
	OS.set_window_size(Vector2(w, h) * s)
	maze = load("res://data_structures/Maze.gd").new(w, h) 
	node_holder = load("res://data_structures/Node_Holder.gd").new(w, h)
	
	maze.generate_maze()
	node_holder.print_walls()
	initialise_walls()
	node_holder.print_walls()
	initialise_players(2)


func initialise_walls():
	maze.put_walls(.1)
	maze.empty_corners_v2(5)
	
	# make_room(2, 5, 6, 3)
	# make_room(15, 7, 4, 4)
	# make_room(21, 12, 7, 5)
	# make_room(32, 16, 4, 6)
	
	var test_bomb = preload("res://World/Bomb.tscn").instance()
	test_bomb.set_position(Vector2(32+16,32+16))
	add_child(test_bomb)
	
	for i in range(maze.width):
		for j in range(maze.height):
			if maze.is_wall(i, j):
				var wall = preload("res://Wall.tscn").instance()
				node_holder.put_wall_at(i, j, wall)
				wall.set_position(Vector2(i*my_scale + my_scale/2, j*my_scale + my_scale/2))
				wall.set_scale(scale_vector)
				add_child(wall)

func initialise_players(n_players):
	var players = []
	var player_keys = [
		["d_key", "s_key", "a_key", "w_key"],
		["ui_right", "ui_down", "ui_left", "ui_up"]
	]
	for _i in range(0, n_players):
		players.append(preload("res://Player/Player.tscn").instance())
	
	for i in range(n_players):
		var dir = Vector2(i % 2, i % 2)	#var dir = Vector2(i % 2, i / 2)		(0, 0) (1, 0) (0, 1 ) (1, 1)
		var aux = my_scale * 1.5 * (Vector2.ONE - dir * 2)
		players[i].set_position(dir * my_scale * Vector2(maze.width, maze.height) + aux)
		players[i].my_init(player_keys[i], players)
		players[i].set_scale(scale_vector)
		add_child(players[i])

