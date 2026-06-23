extends TextureButton

@export var upgrade_resource:Resource

func _on_pressed() -> void:
	Globals.player.upgrades.append(upgrade_resource)
	get_parent().machines_finished += 1
	get_tree().call_group("PerkButtons", "hide")
	


func _on_mouse_entered() -> void:
	Globals.emit_signal("hovering_over_mod", upgrade_resource.description)
