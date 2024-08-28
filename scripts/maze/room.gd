class_name Room extends Node2D

var _tiles:Array[Vector2]
var _position_in_maze: Vector2
var _char: String
var _pattern

func _init(position: Vector2, pattern: PatternUtils.Patterns, symb: String = "O"):
	self._position_in_maze = position
	self._pattern = pattern
	self._tiles = PatternUtils.get_pattern_tiles(pattern)
	self._char = symb

func get_pattern():
	return _pattern

func get_tiles():
	return self._tiles

func get_position_in_maze():
	return _position_in_maze

func get_char():
	return _char

func is_tile_in_room(pos: Vector2) -> bool:
	for tile in _tiles:
		if tile + _position_in_maze == pos:
			return true
	return false

func _to_string() -> String:
	var result = "Position " + str(_position_in_maze) + "\n"
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
