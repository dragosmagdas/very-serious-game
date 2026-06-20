extends StaticBody2D

var kill_req:int = 10
var kills:int = 0

func _ready() -> void:
	Globals.connect("enemy_killed", check_kill_req)

func check_kill_req():
	kills += 1
	if kills >= kill_req:
		$AnimatedSprite2D.animation = str(int($AnimatedSprite2D.animation) % 12 + 1)
		kill_req *= 1.5
