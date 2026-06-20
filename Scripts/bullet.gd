extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	velocity = Vector2(1000, 0).rotated(rotation)
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		area.get_owner().queue_free()
		Globals.emit_signal("enemy_killed")
		queue_free()
