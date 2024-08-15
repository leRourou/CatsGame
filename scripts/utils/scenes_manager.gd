extends Node2D

static var PLAYER_PATH = 'res://scenes/player.tscn'
static var BULLET_PATH = 'res://scenes/bullet.tscn'
static var ENEMY_PATH = 'res://scenes/enemy.tscn'
static var GAME_PATH = 'res://scenes/game.tscn'

var current_scene = null

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
