extends CharacterBody2D

enum directions {FORWARD, BACK, LEFT, RIGHT}

var current_direction:directions = directions.FORWARD
var projectile:PackedScene = preload("res://Scenes/bullet.tscn")
const SPEED:int = 1000
var can_fire:bool = true
@onready var i_frames = $"I-frames"

@export var upgrades:Array[Resource] = []
@export var hp:int = 10

func _ready() -> void:
	Globals.player = self
	Globals.connect("kill_req_met", turn_off_camera)
	$DamageSound.volume_db = Globals.volume
	$ShootSound.volume_db = Globals.volume

func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("Left", "Right")
	velocity.y = Input.get_axis("Up", "Down")
	velocity = velocity.normalized() * SPEED * delta * 40
	
	if Input.is_action_just_pressed("Shoot") and can_fire:
		$ShootSound.play()
		$Camera2D.add_trauma(0.18)
		var bullet_instance = projectile.instantiate()
		Globals.emit_signal("create_bullet", bullet_instance, $Weapon/BulletPos.global_position, $Weapon.rotation)
		for upgrade in upgrades:
			upgrade.apply_upgrade(bullet_instance)
		$Weapon/FireTimer.start()
		can_fire = false
	
	if Input.is_action_just_pressed("Up"):
		current_direction = directions.FORWARD
	if Input.is_action_just_pressed("Down"):
		current_direction = directions.BACK
	if Input.is_action_just_pressed("Left"):
		current_direction = directions.LEFT
	if Input.is_action_just_pressed("Right"):
		current_direction = directions.RIGHT
	
	match current_direction:
		directions.FORWARD:
			if i_frames.is_stopped():
				$PlayerDirection.animation =  "Forward"
			else:
				$PlayerDirection.animation =  "ForwardFlash"
		directions.BACK:
			if i_frames.is_stopped():
				$PlayerDirection.animation =  "Back"
			else:
				$PlayerDirection.animation =  "BackFlash"
		directions.LEFT:
			if i_frames.is_stopped():
				$PlayerDirection.animation =  "Left"
			else:
				$PlayerDirection.animation =  "LeftFlash"
		directions.RIGHT:
			if i_frames.is_stopped():
				$PlayerDirection.animation =  "Right"
			else:
				$PlayerDirection.animation =  "RightFlash"
	
	for area in $Hurtbox.get_overlapping_areas():
		if area.is_in_group("Hitboxes") and i_frames.is_stopped():
			hp -= area.get_owner().damage
			$DamageSound.play()
			$Camera2D.add_trauma(0.3)
			i_frames.start()
	if hp <= 0:
		$GameOver.dead = true
		get_tree().paused = true
	move_and_slide()

func turn_off_camera() -> void:
	$Camera2D.enabled = false

func turn_on_camera() -> void:
	$Camera2D.enabled = true

func _on_fire_timer_timeout() -> void:
	can_fire = true
