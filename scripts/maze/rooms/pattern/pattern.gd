class_name Pattern extends Node

enum Type {SINGLE, SQUARE_2, SQUARE_3, TRIANGLE_1, TRIANGLE_2, TRIANGLE_3, TRIANGLE_4, LONG_2, LONG_3, LARGE_2, LARGE_3}

var _type: Type
var _tiles: Array[Vector2]
var _remove_if_not_placable: Array[Type]
var _patterns: Array[Pattern]

func _init(pattern: Type):
	self._type = pattern
	self._tiles = get_pattern_from_type(pattern)

# Tiles getter
func get_tiles():
	return _tiles

# Type getter
func get_type():
	return _type

# Remove if not placable getter
func get_remove_if_not_placable():
	return _remove_if_not_placable

# Returns pattern tiles from pattern
static func get_pattern_from_type(pattern: Type) -> Array[Vector2]:
	match (pattern):
		Type.SINGLE:
			return create_single_room_pattern()
		Type.SQUARE_2:
			return create_squared_room_pattern(2)
		Type.SQUARE_3:
			return create_squared_room_pattern(3)
		Type.TRIANGLE_1:
			return create_triangle_room_pattern(1)
		Type.TRIANGLE_2:
			return create_triangle_room_pattern(2)
		Type.TRIANGLE_3:
			return create_triangle_room_pattern(3)
		Type.TRIANGLE_4:
			return create_triangle_room_pattern(4)
		Type.LONG_2:
			return create_rectange_tiles_pattern(1, 2)
		Type.LONG_3:
			return create_rectange_tiles_pattern(1, 3)
		Type.LARGE_2:
			return create_rectange_tiles_pattern(2, 1)
		Type.LARGE_3:
			return create_rectange_tiles_pattern(3, 1)
		_:
			return create_single_room_pattern()

static func create_single_room_pattern() -> Array[Vector2]:
	return [Vector2.ZERO]
 
static func create_squared_room_pattern(size: int) -> Array[Vector2]:
	return create_rectange_tiles_pattern(size, size)

static func create_rectange_tiles_pattern(horizontal: int, vertical: int) -> Array[Vector2]:
	var tiles_list: Array[Vector2] = []
	for i in range(horizontal):
		for j in range(vertical):
			tiles_list.append(Vector2(i, j))
	return tiles_list

static func create_triangle_room_pattern(orientation: int) -> Array[Vector2]:
	var tiles = create_squared_room_pattern(2)
	tiles.remove_at(orientation - 1)
	return tiles
