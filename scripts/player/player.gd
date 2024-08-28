class_name Player extends CharacterBody2D
const character_scene = preload("res://scenes/player.tscn")

static var player: Player

const SPEED = 500
const TIME_BETWEEN_SHOOTS = 0.25

var current_speed = 0

@onready var shoot_timer := $ShootTimer as Timer

static func get_player() -> Player:
	if (!player):
		player = character_scene.instantiate()
	return player

func _physics_process(delta):
	move(delta)

func _process(_delta):
	allow_shoot()

func can_shoot():
	return shoot_timer.is_stopped()

func shoot():
	if (!can_shoot()): return
	Bullet.instanciate(self, (get_global_mouse_position() - global_position).normalized())
	shoot_timer.start(TIME_BETWEEN_SHOOTS)

func move(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	
	velocity = direction * SPEED
	
	move_and_slide()

func allow_shoot():
	if Input.is_action_pressed("Shoot"):
		shoot()

func _on_shoot_timer_timeout():
	pass
