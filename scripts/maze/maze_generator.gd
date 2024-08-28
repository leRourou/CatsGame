extends Node

const MAZE_SIZE = 6
const PROBA_TREASURE = 0.02
const PROBA_MINI_BOSS = 0.25
const PROBA_JAIL = 0.8

func generate() -> Maze:
	var maze = Maze.new(MAZE_SIZE)
	generate_special_room(maze, SpecialRoom.Type.START)
	print("test")
	var treasure_count = get_treasure_rooms_count(maze)
	for i in range(treasure_count):
		generate_special_room(maze, SpecialRoom.Type.TREASURE)
	if (ProbaUtils.check(PROBA_MINI_BOSS)):
		generate_special_room(maze, SpecialRoom.Type.MINI_BOSS)
	if (ProbaUtils.check(PROBA_JAIL)):
		generate_special_room(maze, SpecialRoom.Type.JAIL)
	generate_special_room(maze, SpecialRoom.Type.SHOP)
	while not maze.is_maze_complete():
		if (maze.get_placable_patterns().size() == 1):
			fill_maze_with_single_rooms(maze)
		else:
			generate_normal_room(maze)
	return maze

func generate_normal_room(maze: Maze):
	var placable_patterns: Array = maze.get_placable_patterns()
	var pattern = -1
	while (!placable_patterns.has(pattern)):
		pattern = ProbaUtils.check_pondered_dict(PatternInfos.PATTERNS_INFORMATIONS)
	generate_room(maze, pattern, "O")

func generate_special_room(maze: Maze, room_type: SpecialRoom.Type):
	var is_side = SpecialRoom.get_room_side(room_type)
	var char = SpecialRoom.get_char_from_type(room_type)
	var pattern = SpecialRoom.get_pattern_from_type(room_type)
	generate_room(maze, pattern, char, is_side, true)

func generate_room(maze: Maze, pattern: Pattern.Type, char: String, is_side = null, rand_start_pos: bool = false):
	var pos = maze.get_first_position_pattern(pattern, is_side, rand_start_pos)
	if (pos != null):
		var room = Room.new(pos, pattern, char)
		maze.add_room(room)

func fill_maze_with_single_rooms(maze: Maze):
	var pos = maze.get_empty_rand_tile()
	var room = Room.new(pos, Pattern.Type.SINGLE)
	maze.add_room(room)

func get_treasure_rooms_count(maze: Maze, count: int = 1) -> int:
	for _i in maze.get_tile_count():
		if (ProbaUtils.check(PROBA_TREASURE)):
			count += 1
	return count
