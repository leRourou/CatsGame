class_name SpecialRoom extends Room

enum Type {START, FINISH, SHOP, TREASURE, JAIL, MINI_BOSS}

var _type: Type

const ROOMS_INFORMATIONS = {
	Type.START: {
		"char": "S",
		"pattern": Pattern.Type.SINGLE,
		"side": Maze.SideTile.LEFT
	},
	Type.FINISH: {
		"char": "F",
		"pattern": Pattern.Type.SINGLE,
		"side": Maze.SideTile.RIGHT
	},
	Type.SHOP: {
		"char": "B",
		"pattern": Pattern.Type.SINGLE,
	},
	Type.TREASURE: {
		"char": "T",
		"pattern": Pattern.Type.SINGLE,
	},
	Type.JAIL: {
		"char": "J",
		"pattern": Pattern.Type.SQUARE_3,
	},
	Type.MINI_BOSS: {
		"char": "M",
		"pattern": Pattern.Type.SINGLE,
	}
}

func _init(position_in_maze: Vector2, type: Type):
	self._position_in_maze = position_in_maze
	var pattern = get_pattern_from_type(type)
	self._tiles = Pattern.get_pattern_from_type(pattern)
	self._char = get_char_from_type(type)

func get_type():
	return _type

# Returns the side of the room type is it has 
# Returns null if no room side
static func get_room_side(room_type: Type):
	var room_infos = ROOMS_INFORMATIONS[room_type]
	if (room_infos).has("side"):
		return room_infos.side
	return null

# Returns type from Room Type
static func get_pattern_from_type(room_type: Type) -> Pattern.Type:
	return ROOMS_INFORMATIONS[room_type].pattern

# Returns char from Room type
static func get_char_from_type(room_type: Type) -> String:
	return ROOMS_INFORMATIONS[room_type].char
