class_name EnemyStun extends Node2D

@onready var stun_timer := $StunTimer as Timer

func is_stun():
	return !stun_timer.is_stopped()

func stun(time: float):
	stun_timer.start(time)
