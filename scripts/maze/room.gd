class_name Room extends Node

var tiles:Array[Vector2]
var position: Vector2

func is_tile_in_room(pos: Vector2) -> bool:
	for tile in tiles:
		if tile + position == pos:
			return true
	return false

static func create_squared_room(size: int) -> Room:
	return create_rectange_room(size, size)

static func create_rectange_room(horizontal: int, vertical: int) -> Room:
	var room = Room.new()
	var tiles_list: Array[Vector2] = []
	for i in horizontal:
		for j in vertical:
			room.tiles.append(Vector2(i, j))
	return room

func _to_string() -> String:
	var result = "Position " + str(position)
	var max_x = 0
	var max_y = 0
	for tile in tiles:
		if tile.x > max_x:
			max_x = tile.x
		if tile.y > max_y:
			max_y = tile.y
	var grid = []
	for y in range(max_y + 1):
		var row: Array[String] = []
		for x in range(max_x + 1):
			row.append(" ")
		grid.append(row)
	for tile in tiles:
		grid[tile.y][tile.x] = "O"
	for row in grid:
		for cell in row:
			result += cell + " "
		result += "\n"

	return result
