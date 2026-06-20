extends CharacterBody2D

var projectile = preload("res://Scenes/bullet.tscn")
const SPEED = 1000

func _ready() -> void:
	Globals.player = self

func _physics_process(delta: float) -> void:
	velocity.x = Input.get_axis("Left", "Right")
	velocity.y = Input.get_axis("Up", "Down")
	velocity = velocity.normalized() * SPEED * delta * 40
	
	if Input.is_action_just_pressed("Shoot"):
		var bullet_instance = projectile.instantiate()
		Globals.emit_signal("create_bullet", bullet_instance, $Weapon/BulletPos.global_position, $Weapon.rotation)
	
	if Input.is_action_just_pressed("Up"):
		$PlayerDirection.animation = "Forward"
	if Input.is_action_just_pressed("Down"):
		$PlayerDirection.animation = "Back"
	if Input.is_action_just_pressed("Left"):
		$PlayerDirection.animation = "Left"
	if Input.is_action_just_pressed("Right"):
		$PlayerDirection.animation = "Right"
	
	move_and_slide()
