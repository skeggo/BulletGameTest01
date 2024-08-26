extends Node



var consumables = ["res://Heals.tscn","res://attack_boost_consumable.tscn","res://speed_boost_consumable.tscn","res://magnet.tscn"]
var xp = "res://xp_particule.tscn"
var coin_count = 0
var kill_count = 0
var bullet_damage : float = 10.0
var bps = 2.0
var acceleration : float = 200
var pickup_radius = Vector2(1,1)
var to_level_up : float = 100
var leveling : float = 0
var player_position : Vector2
var rotate_bullet = deg_to_rad(270)
var test = true
var paused = false
var four_direction = false
func xp_gain():
	return xp

func get_random_consumbale_mini_boss():
	var chance = randi_range(0,3)
	return consumables[chance]


func get_random_consumbale_enemy():
	var chance = randi_range(0,3)
	var drop_chance = randi_range(0,5)
	if drop_chance == 1:
		return consumables[chance]
	else:
		return "res://nothing.tscn"
