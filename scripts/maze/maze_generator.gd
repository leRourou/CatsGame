extends Node

const MAZE_SIZE = 6
const PROBA_TREASURE = 0.02
const PROBA_MINI_BOSS = 0.25
const PROBA_JAIL = 0.25

func _ready():
	generate()

func generate():
	var maze = Maze.new(MAZE_SIZE)
	generate_room(maze, RoomManager.RoomType.START)
	generate_room(maze, RoomManager.RoomType.FINISH)
	generate_room(maze, RoomManager.RoomType.SHOP)
	var treasure_count = get_treasure_rooms_count(maze)
	for i in range(treasure_count):
		generate_room(maze, RoomManager.RoomType.TREASURE)
	if (ProbaUtils.check(PROBA_MINI_BOSS)):
		generate_room(maze, RoomManager.RoomType.MINI_BOSS)
	if (ProbaUtils.check(PROBA_JAIL)):
		generate_room(maze, RoomManager.RoomType.JAIL)
	var count = 0
	while not maze.is_maze_complete() && count < 15:
		count += 1
		generate_room(maze, RoomManager.RoomType.NORMAL)
	print(maze)

func generate_room(maze: Maze, room_type: RoomManager.RoomType):
	var infos: Dictionary = RoomManager.ROOMS_INFORMATIONS[room_type]
	var size = infos.size
	var room: Room = RoomManager.create_room_from_size(size)
	var pos = get_room_position(maze, infos, room.get_tiles())
	if (pos != null):
		room.set_char(infos.char)
		room.set_position(pos)
		maze.add_room(room)

func get_room_position(maze: Maze, infos: Dictionary, tiles: Array[Vector2]):
	var size: RoomManager.RoomSizes = infos.size
	if (size == RoomManager.RoomSizes.SINGLE):
		if (infos.has("side")):
			return maze.get_empty_side_tile(infos.side)
		return maze.get_empty_rand_tile()
	else:
		return maze.get_first_position_pattern(tiles, size)

func get_treasure_rooms_count(maze: Maze, count: int = 1) -> int:
	for _i in maze.get_tile_count():
		if (ProbaUtils.check(PROBA_TREASURE)):
			count += 1
	return count
