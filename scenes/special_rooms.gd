class_name SpecialRoom extends Room

enum SpecialRoomType { START, FINISH, SHOP, TREASURE, JAIL, MINI_BOSS }

var _type: SpecialRoomType

func _init(position: Vector2, type: SpecialRoomType):
	self._position_in_maze = position
	var pattern = PatternUtils.get_pattern_from_type(type)
	self._tiles = PatternUtils.get_pattern_tiles(pattern)
	self._char = PatternUtils.get_char_from_type(type)

func get_type():
	return _type
