extends Node

enum Patterns { SINGLE, SQUARE_2, SQUARE_3, TRIANGLE_1, \
	TRIANGLE_2, TRIANGLE_3, TRIANGLE_4, LONG_2, LONG_3, LARGE_2, LARGE_3 }

const PATTERNS_INFORMATIONS: Dictionary = {
	Patterns.SINGLE: {
		"weight": 30,
		"remove_if_not_placable": []
	},
	Patterns.SQUARE_2: {
		"weight": 15,
		"remove_if_not_placable": [Patterns.SQUARE_2, Patterns.SQUARE_3]
	},
	Patterns.SQUARE_3: {
		"weight": 5,
		"remove_if_not_placable": []
	},
	Patterns.TRIANGLE_1: {
		"weight": 5,
		"remove_if_not_placable": [Patterns.SQUARE_2, Patterns.SQUARE_3]
	},
	Patterns.TRIANGLE_2: {
		"weight": 5,
		"remove_if_not_placable": [Patterns.SQUARE_2, Patterns.SQUARE_3]
	},
	Patterns.TRIANGLE_3: {
		"weight": 5,
		"remove_if_not_placable": [Patterns.SQUARE_2, Patterns.SQUARE_3]
	},
	Patterns.TRIANGLE_4: {
		"weight": 5,
		"remove_if_not_placable": [Patterns.SQUARE_2, Patterns.SQUARE_3]
	},
	Patterns.LONG_2: {
		"weight": 10,
		"remove_if_not_placable": [
			Patterns.LONG_3,
			Patterns.TRIANGLE_1, 
			Patterns.TRIANGLE_2,
			Patterns.TRIANGLE_3,
			Patterns.TRIANGLE_4,
			Patterns.SQUARE_2,
			Patterns.SQUARE_3,
		]
	},
	Patterns.LONG_3: {
		"weight": 5,
		"remove_if_not_placable": [
			Patterns.SQUARE_3,
		]
	},
	Patterns.LARGE_2: {
		"weight": 10,
		"remove_if_not_placable": [
			Patterns.LARGE_3,
			Patterns.TRIANGLE_1, 
			Patterns.TRIANGLE_2,
			Patterns.TRIANGLE_3,
			Patterns.TRIANGLE_4,
			Patterns.SQUARE_2,
			Patterns.SQUARE_3,
		]
	},
	Patterns.LARGE_3: {
		"weight": 5,
		"remove_if_not_placable": [
			Patterns.SQUARE_3,
		]
	}
}

const ROOMS_INFORMATIONS = {
	SpecialRoom.SpecialRoomType.START: {
		"char": "S",
		"pattern": Patterns.SINGLE,
		"side": Maze.SideTile.LEFT
	},
	SpecialRoom.SpecialRoomType.FINISH: {
		"char": "F",
		"pattern": Patterns.SINGLE,
		"side": Maze.SideTile.RIGHT
	},
	SpecialRoom.SpecialRoomType.SHOP: {
		"char": "B",
		"pattern": Patterns.SINGLE,
	},
	SpecialRoom.SpecialRoomType.TREASURE: {
		"char": "T",
		"pattern": Patterns.SINGLE,
	},
	SpecialRoom.SpecialRoomType.JAIL: {
		"char": "J",
		"pattern": Patterns.SQUARE_3,
	},
	SpecialRoom.SpecialRoomType.MINI_BOSS: {
		"char": "M",
		"pattern": Patterns.SINGLE,
	}
}

# Returns the side of the room type is it has 
# Returns null if no room side
func get_room_side(room_type: SpecialRoom.SpecialRoomType):
	var room_infos = ROOMS_INFORMATIONS[room_type]
	if (room_infos).has("side"):
		return room_infos.side
	return null

# Returns type from Room Type
func get_pattern_from_type(room_type: SpecialRoom.SpecialRoomType) -> Patterns:
	return ROOMS_INFORMATIONS[room_type].pattern

# Returns char from Room type
func get_char_from_type(room_type: SpecialRoom.SpecialRoomType) -> String:
	return ROOMS_INFORMATIONS[room_type].char

# Returns patterns that will be removed when a pattern can't be placed on a maze
func get_patterns_to_remove(pattern: Patterns):
	return PATTERNS_INFORMATIONS[pattern].remove_if_not_placable

# Returns pattern tiles from pattern
func get_pattern_tiles(pattern: Patterns) -> Array[Vector2]:
	match (pattern):
		Patterns.SINGLE:
			return create_single_room_pattern()
		Patterns.SQUARE_2:
			return create_squared_room_pattern(2)
		Patterns.SQUARE_3:
			return create_squared_room_pattern(3)
		Patterns.TRIANGLE_1:
			return create_triangle_room_pattern(1)
		Patterns.TRIANGLE_2:
			return create_triangle_room_pattern(2)
		Patterns.TRIANGLE_3:
			return create_triangle_room_pattern(3)
		Patterns.TRIANGLE_4:
			return create_triangle_room_pattern(4)
		Patterns.LONG_2:
			return create_rectange_tiles_pattern(1,2)
		Patterns.LONG_3:
			return create_rectange_tiles_pattern(1,3)
		Patterns.LARGE_2:
			return create_rectange_tiles_pattern(2,1)
		Patterns.LARGE_3:
			return create_rectange_tiles_pattern(3,1) 
		_:
			return create_single_room_pattern()

#region Patterns
func create_single_room_pattern() -> Array[Vector2]:
	return [Vector2.ZERO]
 
func create_squared_room_pattern(size: int) -> Array[Vector2]:
	return create_rectange_tiles_pattern(size, size)

func create_rectange_tiles_pattern(horizontal: int, vertical: int) -> Array[Vector2]:
	var tiles_list: Array[Vector2] = []
	for i in range(horizontal):
		for j in range(vertical):
			tiles_list.append(Vector2(i, j))
	return tiles_list

func create_triangle_room_pattern(orientation: int) -> Array[Vector2]:
	var tiles = create_squared_room_pattern(2)
	tiles.remove_at(orientation-1)
	return tiles
#endregion
