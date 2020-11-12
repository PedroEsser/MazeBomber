extends Node2D

var maze
var my_scale

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	my_init(41, 23, 16)

func my_init(w, h, s):
	maze = load("res://Maze.gd").new(w, h)
	my_scale = s
	maze.generate_maze()
	initialise_walls()
	initialise_players(2)


func initialise_walls():
	maze.put_walls(.1)
	maze.empty_corners_v2(5)
	# 
	# make_room(2, 5, 6, 3)
	# make_room(15, 7, 4, 4)
	# make_room(21, 12, 7, 5)
	# make_room(32, 16, 4, 6)
	
	for i in range(maze.width):
		for j in range(maze.height):
			if maze.is_wall(i, j):
				var wall = preload("res://Wall.tscn").instance()
				wall.set_position(Vector2(i*my_scale + my_scale/2, j*my_scale + my_scale/2))
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
		var dir = Vector2(i % 2, i / 2)
		var aux = my_scale * 1.5 * (Vector2.ONE - dir * 2)
		players[i].set_position(dir * my_scale * Vector2(maze.width, maze.height) + aux)
		players[i].my_init(player_keys[i])
		add_child(players[i])

