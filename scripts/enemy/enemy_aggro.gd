class_name EnemyAggro extends Node2D

@onready var aggro_timer := $AggroTimer as Timer
@onready var enemy := get_parent() as Enemy

func is_losing_aggro():
	return !aggro_timer.is_stopped()

func remaining_losing_aggro_time():
	return aggro_timer.time_left

func launch_aggro(aggro_time: float):
	aggro_timer.start(aggro_time)

func stop_aggro():
	aggro_timer.stop()

func _on_aggro_timer_timeout():
	enemy.set_state(enemy.States.NEUTRAL)
