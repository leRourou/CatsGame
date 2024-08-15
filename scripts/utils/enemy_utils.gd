extends Node

const enemy_scene = preload("res://scenes/enemy.tscn")

func spawn_enemy(position: Vector2):
	var enemy_to_add = enemy_scene.instantiate() as Enemy
	enemy_to_add.position = position
	return enemy_to_add

