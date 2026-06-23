extends CharacterBody2D

@onready var player = Globals.player
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var calculate_timer: Timer = $CalculateTimer

var base_SPEED:int = 400
var base_hp = 1
var damage = 1
@onready var SPEED:int = base_SPEED + Globals.enemy_speed_boost
@onready var hp:int = base_hp + Globals.enemy_hp_boost:
	set(value):
		print("Value:", value)
		print("HP:", hp)
		hp = value

func _ready() -> void:
	Globals.connect("slot_machine_finished", check_challenges)
	Globals.connect("enemy_frenzy", check_challenges)
	calculate_timer.timeout.connect(_on_calculate_timeout)
	navigation_agent_2d.velocity_computed.connect(_on_velocity_computed)
	
	navigation_agent_2d.path_desired_distance = 4.0
	navigation_agent_2d.target_desired_distance = 4.0
	
	call_deferred("actor_setup")

func _on_calculate_timeout() -> void:
	set_target_position(player.position)

func actor_setup() -> void:
	await get_tree().physics_frame
	set_target_position(player.position)

func set_target_position(player_position: Vector2) -> void:
	navigation_agent_2d.target_position = player_position

func _physics_process(delta: float) -> void:
	if navigation_agent_2d.is_navigation_finished():
		return
	var current_agent_pos = global_position
	var next_path_pos = navigation_agent_2d.get_next_path_position()
	
	var new_velocity = current_agent_pos.direction_to(next_path_pos).normalized() * SPEED * delta * 40
	
	if navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity:Vector2):
	velocity = safe_velocity
	move_and_slide()

func check_challenges():
	await get_tree().create_timer(0.1).timeout
	hp = base_hp + Globals.enemy_hp_boost
	SPEED = base_SPEED + Globals.enemy_speed_boost
