

var width
var height
var current

var directions_1d = []

var path_stack = []
var path_positions = []


func _init(w, h):
	width = w
	height = h
	directions_1d = [1, w, -1, -w]
	var x = floor(discrete(0, width - 2) / 2) * 2 + 1
	var y = floor(discrete(0, height - 2) / 2) * 2 + 1
	current = convert_to_position(x, y)
	path_positions = [current]
	path_stack = [current]


func generate_maze():
	while step():
		pass

func step():
	var next_direction = next_available_random_direction()

	if next_direction == 0:
		if path_stack.empty():
			return false
		current = path_stack.pop_back()
		return true
	walk(next_direction)
	return true

func walk(dir):
	path_positions.append(current + dir)
	path_positions.append(current + 2*dir)
	current += 2*dir
	path_stack.append(current)

func next_available_random_direction():
	var available_directions = []

	for direction in directions_1d:
		var possible_path = current + 2 * direction
		if is_wall_v2(possible_path) && !is_border(possible_path):
			available_directions.append(direction)
	
	if available_directions.empty():
		return 0
	
	return available_directions[discrete(0, available_directions.size())]

func is_path(x, y):
	return convert_to_position(x, y) in path_positions

func is_wall(x, y):
	return !convert_to_position(x, y) in path_positions

func is_path_v2(pos):
	return pos in path_positions

func is_wall_v2(pos):
	return !pos in path_positions

func is_border(pos):
	var p = convert_to_point(pos)
	return p[0] == 0 || p[0] == width - 1 || p[1] == 0 || p[1] == height - 1 || pos > width * height || pos < 0

func convert_to_position(x, y):
	return x + y * width

func convert_to_point(pos):
	return [int(pos) % width, int(pos) / width]

func discrete(i, f):
	var r = f - i
	return floor(randf() * r + i)


func empty_corners(s):

	for i in range(0, s):
		for j in range(0,s-i):
			var posUL = convert_to_position(i + 1, j + 1)
			var posUR = convert_to_position(width - i - 2, j + 1)
			var posDR = convert_to_position(width - i - 2, height - j - 2)
			var posDL = convert_to_position(i + 1, height - j - 2)
			path_positions += [posUL, posUR, posDR, posDL]


func empty_corners_v2(s):
	for i in range(0, s):
		for d in [[0, 1], [1, 0]]:
			var posUL = convert_to_position(1 + i * d[0], 1 + i * d[1])
			var posUR = convert_to_position(width - i * d[0] - 2, i * d[1] + 1)
			var posDR = convert_to_position(width - i * d[0] - 2, height - i * d[1] - 2)
			var posDL = convert_to_position(1 + i * d[0], height - i * d[1] - 2)
			path_positions += [posUL, posUR, posDR, posDL]

func make_room(x, y, w, h):
	for i in range(x, x+w):
		for j in range(y, y+h):
			if is_wall(i, j):
				path_positions.append(convert_to_position(i, j))

func put_walls(percent):
	var n = floor(path_positions.size() * percent)
	for _i in range(0, n):
		path_positions.remove(discrete(0, path_positions.size()))
