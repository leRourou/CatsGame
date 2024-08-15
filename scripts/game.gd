class_name game extends Node2D
static var rng = RandomNumberGenerator.new()

const ENNEMIES_TO_SPAWN = 5

@onready var player = PlayerUtils.get_player()
@onready var camera = $Camera as Camera2D

func _ready():
	add_child(player)
	instanciate_ennemies()

func _process(delta):
	camera_follow_player()

func instanciate_ennemies():
	for i in ENNEMIES_TO_SPAWN:
		var enemy_pos_x = rng.randf_range(-550, 550)
		var enemy_pos_y = rng.randf_range(-300, 300)
		var enemy_to_add_pos = Vector2(enemy_pos_x, enemy_pos_y)
		var ennemy = EnemyUtils.spawn_enemy(enemy_to_add_pos)
		add_child(ennemy)

func camera_follow_player():
	camera.position = player.position
