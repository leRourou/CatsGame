class_name Bullet extends Area2D

const SPEED = 500
const STUN_TIME = 0.0
const DAMAGES = 120
const MAX_DISTANCE = 1000
const KNOCKBACK = 500

var distance_traveled = 0.0
var direction = Vector2()
var launcher: Node

func _ready():
	rotation = direction.angle()
	launcher = get_parent()

func _process(delta):
	move(delta)

func move(delta):
	if distance_traveled < MAX_DISTANCE:
		global_position += direction * SPEED * delta
		distance_traveled += SPEED * delta
	else:
		remove_bullet()

func remove_bullet():
	queue_free()

func _on_body_entered(body):
	if body is Enemy && launcher is Player:
		body.hitted(self)
		remove_bullet()

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body is TileMap):
		remove_bullet()
