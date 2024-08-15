class_name Player extends CharacterBody2D
const bulletPath = preload("res://scenes/bullet.tscn")

const MOVE_SPEED = 500
const TIME_BETWEEN_SHOOTS = 0.25

@onready var shoot_timer := $ShootTimer as Timer

func _physics_process(delta):
	move(delta)

func _process(_delta):
	allow_shoot()

func can_shoot():
	return shoot_timer.is_stopped()

func shoot():
	if (!can_shoot()): return
	var bullet_to_shoot = bulletPath.instantiate()
	add_child(bullet_to_shoot)
	bullet_to_shoot.global_position = position
	bullet_to_shoot.direction = (get_global_mouse_position() - global_position).normalized()
	shoot_timer.start(TIME_BETWEEN_SHOOTS)

func move(_delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	velocity = velocity * MOVE_SPEED
	move_and_slide()

func allow_shoot():
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

func _on_shoot_timer_timeout():
	pass
