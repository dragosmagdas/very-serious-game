extends Node2D

var enemy = preload("res://Scenes/enemy.tscn")
var rng = RandomNumberGenerator.new()
var time_ceiling = 0.5
var frenzied = false

func _ready() -> void:
	Globals.connect("create_bullet", create_bullet)
	Globals.connect("enemy_killed", change_timer)
	Globals.connect("enemy_frenzy", enemy_frenzy)
	Globals.connect("kill_req_met", check_frenzy)

func create_bullet(bullet, bullet_position, bullet_rotation):
	add_child(bullet)
	bullet.global_position = bullet_position
	bullet.rotation = bullet_rotation

func spawn_enemies() -> void:
	var instantiated_enemy = enemy.instantiate()
	add_child(instantiated_enemy)
	instantiated_enemy.global_position = Vector2(rng.randf_range(-1427, 1018), rng.randf_range(-741, 385))

func change_timer() -> void:
	if !frenzied:
		$SpawnTimer.wait_time = max($SpawnTimer.wait_time / 2, time_ceiling)

func special_timer_change(amount) -> void:
	#called by the enemy spawn rate challenge
	$SpawnTimer.wait_time /= amount
	time_ceiling /= amount

func enemy_frenzy():
	frenzied = true
	$SpawnTimer.wait_time = 0.2 / (0.5 * time_ceiling)
	Globals.enemy_hp_boost += 1
	Globals.enemy_speed_boost += 100

func check_frenzy():
	frenzied = false
