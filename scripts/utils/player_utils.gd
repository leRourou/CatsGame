extends Node
const character_scene = preload("res://scenes/player.tscn")

static var player: Player

func get_player() -> Player:
	if (!player):
		player = character_scene.instantiate()
	return player
