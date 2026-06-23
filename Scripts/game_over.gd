extends Control

@export var dead:bool = false

func _physics_process(delta: float) -> void:
	if dead:
		if $GameOverColor.size.y <= 440:
			$GameOverColor.size.y += 10
		elif $GameOverColor.size.y <= 460:
			$GameOverColor/GameOverLabel.show()
			$GameOverColor/Menu.show()
			$GameOverColor/Retry.show()
			$"../Camera2D".add_trauma(0.5)
			$AudioStreamPlayer.play()
			$GameOverColor.size.y = 470

func _on_menu_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_retry_button_down() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/World1.tscn")
