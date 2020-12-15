extends Node2D

var walls

func _init():
	walls = []

func initialise_wall_matrix():
	for _i in range(GlobalVariables.my_height):
		var wall_row = []
		for _j in range(GlobalVariables.my_width):
			wall_row.append(null)
		walls.append(wall_row)

func get_wall_at(x, y):
	#assert(x in range(0, GlobalVariables.my_width) && y in range(0, GlobalVariables.my_height), "(" + str(x) + ", " + str(y) + "), out of range.")
	return walls[x][y]

func put_wall_at(x, y, w):
	walls[y][x] = w

func destroy_wall_at(x, y):
	if walls[y][x] != null:
		walls[y][x].queue_free()
		walls[y][x] = null


func print_walls():
	print("width:", walls[0].size(), ", height:", walls.size())
	for wall_row in walls:
		var line = ""
		for wall in wall_row:
			if wall == null:
				line += " ";
			else:
				line += "#";
		print(line)
