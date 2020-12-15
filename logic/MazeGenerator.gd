extends Node2D

var maze

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	my_init()

func my_init():
	#GlobalVariables.change_scale(32)
	#GlobalVariables.set_dimensions(33, 17)
	OS.set_window_size(Vector2(GlobalVariables.my_width, GlobalVariables.my_height) * GlobalVariables.my_scale)
	maze = load("res://data_structures/Maze.gd").new(GlobalVariables.my_width, GlobalVariables.my_height)
	MapData.initialise_wall_matrix()

	maze.generate_maze()
	#MapData.print_walls()
	initialise_lights(5)
	initialise_walls()
	#MapData.print_walls()
	initialise_players(1)
	


func initialise_walls():
	maze.put_walls(.1)
	maze.empty_corners_v2(5)
	
	# make_room(2, 5, 6, 3)
	# make_room(15, 7, 4, 4)
	# make_room(21, 12, 7, 5)
	# make_room(32, 16, 4, 6)

	var mid_point = Vector2(maze.width/2, maze.height/2) * GlobalVariables.my_scale
	var max_dist = Vector2.ZERO.distance_to(mid_point)
	
	for i in range(maze.width):
		for j in range(maze.height):
			if maze.is_wall(i, j):
				var pos = Vector2(i+.5, j+.5) * GlobalVariables.my_scale
				var wall = preload("res://World/Wall.tscn").instance()
				wall.calculate_hp(1 - pos.distance_to(mid_point)/max_dist)
				MapData.put_wall_at(i, j, wall)
				wall.set_position(pos)
				wall.set_scale(GlobalVariables.scale_vector)
				add_child(wall)

func initialise_players(n_players):
	var players = []

	for _i in range(0, n_players):
		players.append(preload("res://Player/Player.tscn").instance())
	
	for i in range(n_players):
		var dir = Vector2(i % 2, abs(i % 2 - i / 2))	#var dir = Vector2(i % 2, i / 2)		(0, 0) (1, 1) (0, 1) (1, 0)
		var aux = GlobalVariables.my_scale * 1.5 * (Vector2.ONE - dir * 2)
		players[i].set_position(dir * GlobalVariables.my_scale * Vector2(maze.width, maze.height) + aux)
			
	for i in range(0, n_players):
		players[i].my_init(get_keys_for_player(i), players)
		players[i].set_scale(GlobalVariables.scale_vector)
		add_child(players[i])

func initialise_lights(nLights):
	var random_positions = maze.get_random_paths(nLights)
	for pos in random_positions:
		var vec = maze.convert_to_vector(pos)
		var light = preload("res://World/Light_source.tscn").instance()
		light.set_position((vec + Vector2(.5, .5)) * GlobalVariables.my_scale)
		light.set_scale(GlobalVariables.scale_vector)
		add_child(light)
		
	

func get_keys_for_player(i):
	return ["p" + str(i+1) + "_right",
			"p" + str(i+1) + "_down", 
			"p" + str(i+1) + "_left", 
			"p" + str(i+1) + "_up", 
			"p" + str(i+1) + "_bomb"]
