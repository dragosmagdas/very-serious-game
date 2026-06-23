extends TextureButton

@export var challenge_resource:Resource

func _on_pressed() -> void:
	challenge_resource.apply_challenge()
	get_parent().machines_finished += 1
	get_tree().call_group("EvilButtons", "hide")

func _on_mouse_entered() -> void:
	Globals.emit_signal("hovering_over_mod", challenge_resource.description)
