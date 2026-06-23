extends Node

signal create_bullet(bullet_instance, bullet_position, bullet_rotation)
signal enemy_killed()
signal kill_req_met()
signal increase_spawn_rate(amount)
signal enemy_frenzy()
signal slot_machine_finished()
signal hovering_over_mod(text)
signal shake_screen(amount)

var player
var enemy_speed_boost:int = 0
var enemy_hp_boost:int = 0
var volume:float = 0.0
