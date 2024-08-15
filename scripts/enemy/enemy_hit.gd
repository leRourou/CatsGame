class_name EnemyHit extends Node2D

const HITTED_TIME = 0.2

@onready var enemy = get_parent() as Enemy
@onready var hit_timer = $HitTimer as Timer

var hit_position: Vector2
var knockback_position: Vector2

func launch_hit_timer():
	hit_timer.start(HITTED_TIME)

func remaining_hit_time():
	return hit_timer.time_left

func hitted(bullet: Bullet):
	hit_position = enemy.position
	knockback_position = enemy.position + bullet.direction * bullet.KNOCKBACK
	if (bullet.STUN_TIME > 0):
		enemy.stun_manager.stun(bullet.STUN_TIME)
	enemy.set_state(enemy.States.HITTED)
	enemy.health -= bullet.DAMAGES
	if enemy.health <= 0:
		enemy.kill()
	launch_hit_timer()

func _on_hit_timer_timeout():
	enemy.set_state(enemy.States.ATTACKING)

func get_next_position():
	return hit_position.lerp(knockback_position, HITTED_TIME - remaining_hit_time())
