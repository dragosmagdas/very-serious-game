extends Control



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/World1.tscn")

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.animation = str(int($AnimatedSprite2D.animation) % 12 + 1)


func _on_button_3_pressed() -> void:
	if $Button.visible:
		get_tree().call_group("NotOptions", "hide")
		$Button3.text = "Back"
		$VScrollBar.show()
		$VolumeLabel.show()
		
	else:
		get_tree().call_group("NotOptions", "show")
		$Button3.text = "Options"
		$VScrollBar.hide()
		$VolumeLabel.hide()

func _on_v_scroll_bar_value_changed(value: float) -> void:
	Globals.volume = $VScrollBar.value
