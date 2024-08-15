class_name Maze extends Node
static var rng = RandomNumberGenerator.new()

enum Rooms {FILLED_ROOM=-1, EMPTY_ROOM = 0, START_ROOM = 1, BIG_ROOM = 2, LONG_ROOM = 3, TREASURE_ROOM = 5, END_ROOM = 99 }

var size: int
var rooms: Array[Room]

func _init(size: int):
	self.size = size
	rooms = []

func get_room_at_tile():

func is_tile_empty(pos: Vector2):
	for room in rooms:
		if (room.is_tile_in_room(pos)):
			return false
	return true

func can_place_room(room: Room):
	for tile in room.tiles:
		if (!is_tile_empty(room.position + tile)):
			return false
	return true

func add_room(room: Room):
	if (can_place_room(room)):
		rooms.append(room)

func _to_string() -> String:
	var output = ""
	for y in range(size):
		for x in range(size):
			var pos = Vector2(x, y)
			if is_tile_empty(pos):
				output += "O "
			else:
				output += "X "
		output += "\n"  # Pour aller à la ligne après chaque rangée
	return output
