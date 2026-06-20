extends CharacterBody2D

const SPEED:float = 600

@onready var player = Globals.player
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var calculate_timer: Timer = $CalculateTimer

func _ready() -> void:
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
