extends Node

var MAZE_SIZE = 10

func _ready():
	var maze = Maze.new(MAZE_SIZE)
	var square_room = Room.create_squared_room(5)
	square_room.position = Vector2(1,1)
	maze.add_room(square_room)
	print(maze)
