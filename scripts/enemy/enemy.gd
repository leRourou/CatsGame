class_name Enemy extends CharacterBody2D
const bulletPath = preload("res://scenes/bullet.tscn")

enum States {NEUTRAL, ATTACKING, HITTED}

const SPEED = 100
const TIME_BEFORE_LOSING_AGGRO = 3
const MAX_VISION = 200

@onready var nav_manager := $Navigation as EnemyNav
@onready var aggro_manager := $Aggro as EnemyAggro
@onready var stun_manager := $Stun as EnemyStun
@onready var hit_manager := $Hit as EnemyHit
@onready var sprite := $Sprite as Sprite2D
@onready var shoot_manager := $ShootTimer as Timer

var state: States = States.NEUTRAL
var health = 500
var suspicious_level = 0.0

func _ready():
	set_state(States.NEUTRAL)

func _physics_process(delta):
	match (self.state):
		States.ATTACKING:
			if (shoot_manager.is_stopped()):
				shoot_manager.start(2)
			if (!stun_manager.is_stun()):
				move_to_player()
			if (get_distance_to_player() > 500):
				if (!aggro_manager.is_losing_aggro()):
					aggro_manager.launch_aggro(TIME_BEFORE_LOSING_AGGRO)
		States.NEUTRAL:
			if (get_distance_to_player() < MAX_VISION):
				if (nav_manager.search_player(MAX_VISION)):
					set_state(States.ATTACKING)
		States.HITTED:
			global_position = hit_manager.get_next_position()

func set_state(state_to_set: States):
	state = state_to_set
	match state_to_set:
		States.ATTACKING:
			if (aggro_manager.is_losing_aggro()):
				aggro_manager.stop_aggro()
			set_color(Color(1,0,0))
		States.NEUTRAL:
			shoot_manager.stop()
			set_color(Color(0,1,0))
		States.HITTED:
			shoot_manager.stop()
			set_color(Color(0,0,1))

func get_distance_to_player() -> float:
	return position.distance_to(Player.get_player().position)

func set_color(color: Color):
	sprite.self_modulate = color

func shoot():
	Bullet.instanciate(self, (Player.get_player().position - position).normalized())
	shoot_manager.start(2)

func move_to_player():
	var dir = nav_manager.get_direction()
	velocity = dir * SPEED
	move_and_slide()

func hitted(bullet: Bullet):
	if (bullet.get_launcher() is Player):
		hit_manager.hitted(bullet)

func kill():
	queue_free()

func _on_shoot_timer_timeout():
	shoot()
