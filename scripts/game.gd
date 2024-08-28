class_name game extends Node2D
const roomPath = preload("res://scenes/Room.tscn")

static var rng = RandomNumberGenerator.new()

const ENNEMIES_TO_SPAWN = 5
var maze: Maze

@onready var player = Player.get_player()
@onready var camera = $Camera as Camera2D
@onready var maze_rooms = $Maze/Rooms as Node2D

func _ready():
	add_maze()
	add_child(player)
	instanciate_ennemies()

func _process(delta):
	camera_follow_player()

func add_maze():
	var maze = MazeGenerator.generate()
	var rooms: Array[Room] = maze.get_rooms()
	var room_scene = roomPath.instantiate()
	var repo = room_scene.get_child(0)
	for room in rooms:
		var single_room_instance = repo.get_normal_room(room.get_pattern())
		var pos =  room.get_position_in_maze() * 16 * 64
		print("-----------")
		print(room)
		print(room.get_pattern())
		print(single_room_instance)
		print("-----------")
		single_room_instance.position = pos
		maze_rooms.add_child(single_room_instance)
	print(maze)

func instanciate_ennemies():
	for i in ENNEMIES_TO_SPAWN:
		var enemy_pos_x = rng.randf_range(-550, 550)
		var enemy_pos_y = rng.randf_range(-300, 300)
		var enemy_to_add_pos = Vector2(enemy_pos_x, enemy_pos_y)
		var ennemy = EnemyUtils.spawn_enemy(enemy_to_add_pos)
		add_child(ennemy)

func camera_follow_player():
	camera.position = player.position
