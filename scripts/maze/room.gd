class_name Room extends Node

var _tiles:Array[Vector2]
var _position: Vector2
var _char: String

func _init(position: Vector2 = Vector2(0,0), symb: String = "O"):
	self._position = position
	self._char = symb
	self._tiles = []

func get_tiles():
	return self._tiles
func set_tiles(tiles: Array[Vector2]) -> Room:
	self._tiles = tiles
	return self

func get_position():
	return _position
func set_position(position: Vector2) -> Room:
	self._position = position
	return self

func get_char():
	return _char
func set_char(char: String):
	self._char = char
	return self

func get_all_positions() -> Array[Vector2]:
	var pos_list: Array[Vector2] = []
	for tile in get_tiles():
		pos_list.append(tile + get_position())
	return pos_list

func is_tile_in_room(pos: Vector2) -> bool:
	for tile in get_tiles():
		if tile + get_position() == pos:
			return true
	return false

func _to_string() -> String:
	var result = "Position " + str(get_position()) + "\n"
	var max_x = 0
	var max_y = 0
	for tile in _tiles:
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
	for tile in get_tiles():
		grid[tile.y][tile.x] = "O"
	for row in grid:
		for cell in row:
			result += cell + " "
		result += "\n"

	return result
