extends Control

var playing_start_anim = true
var playing_loop_anim = false
var rng = RandomNumberGenerator.new()
var upgrade1
var upgrade2
var upgrade3
var challenge1
var challenge2
var challenge3
var up_button = preload("res://Scenes/upgrade_button.tscn")
var evil_button = preload("res://Scenes/ChallengeButton.tscn")
var button_offset = Vector2(-5, -6)
var machines_finished: int = 0:
	set(value):
		if value == 2:
			stop_machine()
			value = 0
		machines_finished = value

const upgrades:Array[String] = ["res://Modifiers/Upgrades/SpeedUpgrade.tres", "res://Modifiers/Upgrades/PierceUpgrade.tres", "res://Modifiers/Upgrades/DamageUpgrade.tres"]
const challenges:Array[String] = ["res://Modifiers/Challenges/EnemySpawnChallenge.tres", "res://Modifiers/Challenges/EnemySpeedChallenge.tres"]

func _ready() -> void:
	Globals.connect("kill_req_met", activate_machine)
	Globals.connect("hovering_over_mod", change_label_text)

func change_label_text(text):
	$Label.text = text

func activate_machine():
	show()
	$Sprite2D.show()
	$Sprite2D2.show()
	$MachineCamera.enabled = true
	get_tree().paused = true
	$Sprite2D/AnimatedSprite2D.play("StartAnim")
	$Sprite2D/AnimatedSprite2D2.play("StartAnim")
	$Sprite2D/AnimatedSprite2D3.play("StartAnim")
	$Sprite2D2/AnimatedSprite2D.play("StartAnim")
	$Sprite2D2/AnimatedSprite2D2.play("StartAnim")
	$Sprite2D2/AnimatedSprite2D3.play("StartAnim")

func stop_machine():
	Globals.emit_signal("slot_machine_finished")
	hide()
	$MachineCamera.enabled = false
	Globals.player.turn_on_camera()
	get_tree().paused = false
	$Sprite2D/AnimatedSprite2D.animation = "StartAnim"
	$Sprite2D/AnimatedSprite2D2.animation = "StartAnim"
	$Sprite2D/AnimatedSprite2D3.animation = "StartAnim"
	$Sprite2D2/AnimatedSprite2D.animation = "StartAnim"
	$Sprite2D2/AnimatedSprite2D2.animation = "StartAnim"
	$Sprite2D2/AnimatedSprite2D3.animation = "StartAnim"

func _on_animated_sprite_2d_animation_finished() -> void:
	if playing_start_anim:
		playing_start_anim = false
		playing_loop_anim = true
		$Sprite2D/AnimatedSprite2D.play("LoopAnim")
		$Sprite2D/AnimatedSprite2D2.play("LoopAnim")
		$Sprite2D/AnimatedSprite2D3.play("LoopAnim")
	elif playing_loop_anim:
		playing_loop_anim = false
		$Sprite2D/AnimatedSprite2D.play("EndAnim")
		$Sprite2D/AnimatedSprite2D2.play("EndAnim")
		$Sprite2D/AnimatedSprite2D3.play("EndAnim")
	else:
		var PerkButton1 = up_button.instantiate()
		add_child(PerkButton1)
		PerkButton1.global_position = $Sprite2D/AnimatedSprite2D.global_position
		upgrade1 = load(upgrades[rng.randi_range(0, len(upgrades) - 1)])
		PerkButton1.upgrade_resource = upgrade1
		PerkButton1.texture_normal = upgrade1.texture
		PerkButton1.add_to_group("PerkButtons")
		var PerkButton2 = up_button.instantiate()
		add_child(PerkButton2)
		PerkButton2.global_position = $Sprite2D/AnimatedSprite2D2.global_position
		upgrade2 = load(upgrades[rng.randi_range(0, len(upgrades) - 1)])
		PerkButton2.upgrade_resource = upgrade2
		PerkButton2.texture_normal = upgrade2.texture
		PerkButton2.add_to_group("PerkButtons")
		var PerkButton3 = up_button.instantiate()
		add_child(PerkButton3)
		PerkButton3.global_position = $Sprite2D/AnimatedSprite2D3.global_position
		upgrade3 = load(upgrades[rng.randi_range(0, len(upgrades) - 1)])
		PerkButton3.upgrade_resource = upgrade3
		PerkButton3.texture_normal = upgrade3.texture
		PerkButton3.add_to_group("PerkButtons")
		


func _on_animated_sprite_2d_evil_animation_finished() -> void:
	if playing_start_anim:
		$Sprite2D2/AnimatedSprite2D.play("LoopAnim")
		$Sprite2D2/AnimatedSprite2D2.play("LoopAnim")
		$Sprite2D2/AnimatedSprite2D3.play("LoopAnim")
	elif playing_loop_anim:
		$Sprite2D2/AnimatedSprite2D.play("EndAnim")
		$Sprite2D2/AnimatedSprite2D2.play("EndAnim")
		$Sprite2D2/AnimatedSprite2D3.play("EndAnim")
	else:
		var EvilButton1 = evil_button.instantiate()
		add_child(EvilButton1)
		EvilButton1.global_position = $Sprite2D2/AnimatedSprite2D.global_position + button_offset
		challenge1 = load(challenges[rng.randi_range(0, len(challenges) - 1)])
		EvilButton1.challenge_resource = challenge1
		EvilButton1.texture_normal = challenge1.texture
		EvilButton1.add_to_group("EvilButtons")
		var EvilButton2 = evil_button.instantiate()
		add_child(EvilButton2)
		EvilButton2.global_position = $Sprite2D2/AnimatedSprite2D2.global_position + button_offset
		challenge2 = load(challenges[rng.randi_range(0, len(challenges) - 1)])
		EvilButton2.challenge_resource = challenge2
		EvilButton2.texture_normal = challenge2.texture
		EvilButton2.add_to_group("EvilButtons")
		var EvilButton3 = evil_button.instantiate()
		add_child(EvilButton3)
		EvilButton3.global_position = $Sprite2D2/AnimatedSprite2D3.global_position + button_offset
		challenge3 = load(challenges[rng.randi_range(0, len(challenges) - 1)])
		EvilButton3.challenge_resource = challenge3
		EvilButton3.texture_normal = challenge3.texture
		EvilButton3.add_to_group("EvilButtons")
		
