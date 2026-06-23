extends StaticBody2D

var kill_req:int = 10
var kills:int = 0

func _ready() -> void:
	Globals.connect("enemy_killed", check_kill_req)

func check_kill_req():
	kills += 1
	if kills >= kill_req:
		$AnimatedSprite2D.animation = str(int($AnimatedSprite2D.animation) % 12 + 1)
		kill_req = round(kill_req * 1.5)
		kills = 0
		Globals.player.hp = 10
		Globals.emit_signal("kill_req_met")
		if $AnimatedSprite2D.animation == "12":
			Globals.emit_signal("enemy_frenzy")
