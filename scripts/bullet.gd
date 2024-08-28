class_name Bullet extends Area2D
const bulletPath = preload("res://scenes/bullet.tscn")

const SPEED = 1500
const STUN_TIME = 0.0
const DAMAGES = 120
const MAX_DISTANCE = 1000
const KNOCKBACK = 500

var distance_traveled = 0.0

var _direction: Vector2
var _launcher: Node

static func instanciate(launcher: Node, direction: Vector2):
	var bullet_to_shoot = bulletPath.instantiate()
	launcher.get_parent().add_child(bullet_to_shoot)
	bullet_to_shoot.set_direction(direction)
	bullet_to_shoot.set_launcher(launcher)
	bullet_to_shoot.global_position = launcher.global_position
	return

func get_direction() -> Vector2:
	return _direction

func set_direction(direction: Vector2) -> Bullet:
	_direction = direction
	return self

func get_launcher() -> Node:
	return _launcher

func set_launcher(launcher: Node) -> Bullet:
	_launcher = launcher
	return self

func _process(delta):
	move(delta)

func move(delta):
	if distance_traveled < MAX_DISTANCE:
		global_position += _direction * SPEED * delta
		distance_traveled += SPEED * delta
	else:
		remove_bullet()

func remove_bullet():
	queue_free()

func _on_body_entered(body):
	if body is Enemy && _launcher is Player:
		body.hitted(self)
		remove_bullet()

func _on_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if (body is TileMap):
		remove_bullet()
