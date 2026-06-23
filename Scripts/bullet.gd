extends CharacterBody2D

@export var speed = 1000
@export var damage = 1
@export var can_pierce = false

var enemies_hit:Array = []

func _ready() -> void:
	$DamageSound.volume_db = Globals.volume

func _physics_process(_delta: float) -> void:
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtboxes") and !enemies_hit.has(area):
		enemies_hit.append(area)
		$DamageSound.play()
		Globals.emit_signal("shake_screen", 0.05)
		area.get_owner().hp -= damage
		if area.get_parent().hp <= 0:
			area.get_parent().queue_free()
			Globals.emit_signal("enemy_killed")
		if !can_pierce:
			hide()
			$Area2D/CollisionShape2D.disabled = true


func _on_damage_sound_finished() -> void:
	if !can_pierce:
		queue_free()
