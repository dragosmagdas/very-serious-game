extends Node2D

func _ready() -> void:
	Globals.connect("create_bullet", create_bullet)

func create_bullet(bullet, bullet_position, bullet_rotation):
	add_child(bullet)
	bullet.global_position = bullet_position
	bullet.rotation = bullet_rotation
