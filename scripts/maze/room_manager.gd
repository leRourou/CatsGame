extends Node

enum RoomType { NORMAL, START, FINISH, SHOP, TREASURE, JAIL, MINI_BOSS }

enum RoomSizes { NOT_DEFINED, SINGLE, SQUARE_2, SQUARE_3, TRIANGLE_1, \
	TRIANGLE_2, TRIANGLE_3, TRIANGLE_4, LONG_2, LONG_3, LARGE_2, LARGE_3 }

const PATTERNS_INFORMATIONS: Dictionary = {
	RoomSizes.SINGLE: {
		"weight": 30,
		"remove_if_not_placable": -1
	},
	RoomSizes.SQUARE_2: {
		"weight": 15,
		"remove_if_not_placable": [RoomSizes.SQUARE_2, RoomSizes.SQUARE_3]
	},
	RoomSizes.SQUARE_3: {
		"weight": 5,
		"remove_if_not_placable": []
	},
	RoomSizes.TRIANGLE_1: {
		"weight": 5,
		"remove_if_not_placable": [RoomSizes.SQUARE_2, RoomSizes.SQUARE_3]
	},
	RoomSizes.TRIANGLE_2: {
		"weight": 5,
		"remove_if_not_placable": [RoomSizes.SQUARE_2, RoomSizes.SQUARE_3]
	},
	RoomSizes.TRIANGLE_3: {
		"weight": 5,
		"remove_if_not_placable": [RoomSizes.SQUARE_2, RoomSizes.SQUARE_3]
	},
	RoomSizes.TRIANGLE_4: {
		"weight": 5,
		"remove_if_not_placable": [RoomSizes.SQUARE_2, RoomSizes.SQUARE_3]
	},
	RoomSizes.LONG_2: {
		"weight": 10,
		"remove_if_not_placable": [
			RoomSizes.LONG_3,
			RoomSizes.TRIANGLE_1, 
			RoomSizes.TRIANGLE_2,
			RoomSizes.TRIANGLE_3,
			RoomSizes.TRIANGLE_4,
			RoomSizes.SQUARE_2,
			RoomSizes.SQUARE_3,
		]
	},
	RoomSizes.LONG_3: {
		"weight": 5,
		"remove_if_not_placable": [
			RoomSizes.SQUARE_3,
		]
	},
	RoomSizes.LARGE_2: {
		"weight": 10,
		"remove_if_not_placable": [
			RoomSizes.LARGE_3,
			RoomSizes.TRIANGLE_1, 
			RoomSizes.TRIANGLE_2,
			RoomSizes.TRIANGLE_3,
			RoomSizes.TRIANGLE_4,
			RoomSizes.SQUARE_2,
			RoomSizes.SQUARE_3,
		]
	},
	RoomSizes.LARGE_3: {
		"weight": 5,
		"remove_if_not_placable": [
			RoomSizes.SQUARE_3,
		]
	}
}


const ROOMS_INFORMATIONS = {
	RoomType.NORMAL: {
		"char": "O",
		"size": RoomSizes.NOT_DEFINED,
	},
	RoomType.START: {
		"char": "S",
		"size": RoomSizes.SINGLE,
		"side": Maze.SideTile.LEFT
	},
	RoomType.FINISH: {
		"char": "F",
		"size": RoomSizes.SINGLE,
		"side": Maze.SideTile.RIGHT
	},
	RoomType.SHOP: {
		"char": "B",
		"size": RoomSizes.SINGLE,
	},
	RoomType.TREASURE: {
		"char": "T",
		"size": RoomSizes.SINGLE,
	},
	RoomType.JAIL: {
		"char": "J",
		"size": RoomSizes.SQUARE_3,
	},
	RoomType.MINI_BOSS: {
		"char": "M",
		"size": RoomSizes.SINGLE,
	}
}

func create_room_from_size(size: RoomSizes) -> Room:
	if (size == RoomSizes.NOT_DEFINED):
		size = ProbaUtils.check_pondered_dict(PATTERNS_INFORMATIONS)
	match (size):
		RoomSizes.SINGLE:
			return RoomManager.create_single_room()
		RoomSizes.SQUARE_2:
			return RoomManager.create_squared_room(2)
		RoomSizes.SQUARE_3:
			return RoomManager.create_squared_room(3)
		RoomSizes.TRIANGLE_1:
			return RoomManager.create_triangle_room(1)
		RoomSizes.TRIANGLE_2:
			return RoomManager.create_triangle_room(2)
		RoomSizes.TRIANGLE_3:
			return RoomManager.create_triangle_room(3)
		RoomSizes.TRIANGLE_4:
			return RoomManager.create_triangle_room(4)
		RoomSizes.LONG_2:
			return RoomManager.create_rectange_tiles(2,1)
		RoomSizes.LONG_3:
			return RoomManager.create_rectange_tiles(3,1)
		RoomSizes.LARGE_2:
			return RoomManager.create_rectange_tiles(1,2)
		RoomSizes.LARGE_3:
			return RoomManager.create_rectange_tiles(1,3) 
		_:
			return RoomManager.create_single_room()

func create_single_room() -> Room:
	return Room.new().set_tiles([Vector2(0,0)])

func create_squared_room(size: int) -> Room:
	return create_rectange_tiles(size, size)

func create_rectange_tiles(horizontal: int, vertical: int) -> Room:
	var tiles_list: Array[Vector2] = []
	for i in range(horizontal):
		for j in range(vertical):
			tiles_list.append(Vector2(i, j))
	return Room.new().set_tiles(tiles_list)

func create_triangle_room(orientation: int) -> Room:
	var room = create_squared_room(2)
	room.get_tiles().remove_at(orientation)
	return room
