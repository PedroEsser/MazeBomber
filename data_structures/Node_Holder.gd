
var walls

func _init(w, h):
	initialise_wall_matrix(w, h)

func initialise_wall_matrix(w, h):
	walls = []
	for _i in range(h):
		var wall_row = []
		for _j in range(w):
			wall_row.append(null)
		walls.append(wall_row)

func put_wall_at(x, y, w):
	walls[y][x] = w

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
