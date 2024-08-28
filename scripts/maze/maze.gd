class_name Maze extends Node
static var rng = RandomNumberGenerator.new()

enum SideTile {TOP, BOTTOM, LEFT, RIGHT}

var _size: int
var _rooms: Array[Room]
var tiles: Array[Vector2]
var _placable_patterns: Array

func _init(size: int):
	self._size = size
	_rooms = []
	tiles = []
	_placable_patterns = Pattern.Type.values()
	for y in range(size):
		for x in range(size):
			tiles.append(Vector2(x, y))

func get_rooms():
	return _rooms

func is_maze_complete() -> bool:
	return tiles.size() == 0

func get_placable_patterns():
	return _placable_patterns

# Returns the first position the pattern can be placed
func get_first_position_pattern(pattern: Pattern.Type, is_side = null, rand_start_pos = true):
	if (pattern == Pattern.Type.SINGLE):
		if (is_side):
			return get_empty_side_tile(is_side)
		return get_empty_rand_tile()
		
	var pattern_tiles = Pattern.get_pattern_from_type(pattern)
	var cursor = Vector2.ZERO
	if (rand_start_pos):
		cursor = get_empty_rand_tile()
	for tile in tiles:
		if (rand_start_pos):
			tile = Vector2(int(tile.x + cursor.x) % _size, int(tile.x + cursor.x) % _size)
		var can_place = true
		for pattern_tile in pattern_tiles:
			var pos = tile + pattern_tile
			if not is_tile_empty(pos):
				can_place = false
				break
		if (can_place):
			return tile
	remove_placable_patterns(pattern)
	return null

# Removes patterns that can be placed in the maze
func remove_placable_patterns(pattern_type: Pattern.Type):
	var patterns_to_remove = PatternInfos.get_patterns_to_remove(pattern_type)
	for pattern_to_remove in patterns_to_remove:
		_placable_patterns.erase(pattern_to_remove)

func get_rand_tile():
	var index = rng.randi_range(0, tiles.size() - 1)
	return tiles[index]

func get_side_tile(side_tile: SideTile) -> Vector2:
	var rand_side = rng.randi_range(0, _size - 1)
	match side_tile:
		SideTile.TOP:
			return Vector2(rand_side, 0)
		SideTile.BOTTOM:
			return Vector2(rand_side, _size - 1)
		SideTile.LEFT:
			return Vector2(0, rand_side)
		SideTile.RIGHT:
			return Vector2(_size - 1, rand_side)
	return Vector2()

# Returns the total of tiles of the maze
func get_tile_count():
	return _size * _size

# Returns the amount of empty tiles
func get_empty_tiles_count():
	return get_tile_count() - tiles.size()

# Returns a random empty tile located on a specific side of the maze
func get_empty_side_tile(side_tile: SideTile) -> Vector2:
	var tile = get_side_tile(side_tile)
	while not is_tile_empty(tile):
		tile = get_side_tile(side_tile)
	return tile

# Returns a random empty tile of the maze
func get_empty_rand_tile():
	var tile = get_rand_tile()
	while not is_tile_empty(tile):
		tile = get_rand_tile()
	return tile

# Returns if a tile is empty or not from his position on the maze
func is_tile_empty(pos: Vector2):
	return tiles.has(pos)

# Add a room to the maze
func add_room(room: Room) -> bool:
	_rooms.append(room)
	for tile in room.get_pattern().get_tiles():
		tiles.erase(room.get_position_in_maze() + tile)
	return true

# Returns the room located at a specific tile position
func get_room_at_tile(pos: Vector2) -> Room:
	for room in _rooms:
		if (room.is_tile_in_room(pos)):
			return room
	return null

func _to_string() -> String:
	var output = ""
	for y in range(_size):
		for x in range(_size):
			var pos = Vector2(x, y)
			var room = get_room_at_tile(pos)
			if room:
				output += room.get_char() + " "
			else:
				output += "X "
		output += "\n"
	return output
