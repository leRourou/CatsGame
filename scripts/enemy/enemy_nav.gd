class_name EnemyNav extends Node2D

@onready var player:Player = PlayerUtils.get_player()
@onready var nav_agent = $NavigationAgent as NavigationAgent2D
@onready var vision = $Vision as RayCast2D

func _ready():
	make_path_to_player()

func make_path_to_player():
	nav_agent.target_position = player.global_position

func get_direction():
	return to_local(nav_agent.get_next_path_position()).normalized()

func search_player(max_vision: int) -> bool:
	vision.target_position = (player.global_position - global_position).normalized() * max_vision
	if (vision.is_colliding()):
		var collider = vision.get_collider()
		if (collider is Player):
			return true
	return false

func _on_navigation_timer_timeout():
	make_path_to_player()
