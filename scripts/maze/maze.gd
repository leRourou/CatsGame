class_name Maze extends Node
static var rng = RandomNumberGenerator.new()

enum SideTile { TOP, BOTTOM, LEFT, RIGHT }

var size: int
var rooms: Array[Room]
var tiles: Array[Vector2]
var placable_patterns: Array

func _init(size: int):
	self.size = size
	rooms = []
	tiles = []
	placable_patterns = RoomManager.RoomSizes.keys()
	for y in range(size):
		for x in range(size):
			tiles.append(Vector2(x, y))

func get_first_position_pattern(pattern: Array[Vector2], room_size: RoomManager.RoomSizes):
	for tile in tiles:
		var can_place = true
		for pattern_tile in pattern:
			var pos = tile + pattern_tile
			if not is_tile_empty(pos):
				can_place = false
				break
		if (can_place):
			return tile
	#remove_placable_patterns(room_size)
	return null

func get_tile_count():
	return size * size

func get_rand_tile():
	var index = rng.randi_range(0, tiles.size() - 1)
	return tiles[index]

func get_side_tile(side_tile: SideTile) -> Vector2:
	var rand_side = rng.randi_range(0, size - 1)
	match side_tile:
		SideTile.TOP:
			return Vector2(rand_side, 0)
		SideTile.BOTTOM:
			return Vector2(rand_side, size - 1)
		SideTile.LEFT:
			return Vector2(0, rand_side)
		SideTile.RIGHT:
			return Vector2(size - 1, rand_side)
	return Vector2()

func get_empty_side_tile(side_tile: SideTile) -> Vector2:
	var tile = get_side_tile(side_tile)
	while not is_tile_empty(tile):
		tile = get_side_tile(side_tile)
	return tile

func get_empty_rand_tile():
	var tile = get_rand_tile()
	while not is_tile_empty(tile):
		tile = get_rand_tile()
	return tile

func get_room_at_tile(pos: Vector2) -> Room:
	for room in rooms:
		if (room.is_tile_in_room(pos)):
			return room
	return null

func is_tile_empty(pos: Vector2):
	return tiles.has(pos)

func can_place_room(room: Room):
	for tile in room.get_tiles():
		if (!is_tile_empty(room.get_position() + tile)):
			return false
	return true

func add_room(room: Room) -> bool:
	if (can_place_room(room)):
		rooms.append(room)
		for tile in room.get_tiles():
			tiles.erase(room.get_position() + tile)
		return true
	return false

func is_maze_complete() -> bool:
	return tiles.size() == 0

func _to_string() -> String:
	var output = ""
	for y in range(size):
		for x in range(size):
			var pos = Vector2(x, y)
			var room = get_room_at_tile(pos)
			if room:
				output += room.get_char() + " "
			else:
				output += "X "
		output += "\n"
	return output
