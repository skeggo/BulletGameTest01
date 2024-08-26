extends Node2D

var time : float = 2000000000.0
var minutes : int = 0
var seconds : int = 0
var mini_boss_load = preload("res://mini_boss.tscn")
@export var player:CharacterBody2D
func _ready():
	pass # Replace with function body.

func mini_boss_spwan():
	var mini_boss = mini_boss_load.instantiate()
	var enemy_spawner_postion = get_parent().get_node("Enemy_Spawner").get_node("Sprite2D").get_global_position()
	mini_boss.position = enemy_spawner_postion
	add_child(mini_boss)

func _process(delta):
	time -= delta
	seconds = fmod(time,60)
	minutes = fmod(time,3600)/60
	$Panel/Min.text = "%02d" % minutes
	$Panel/Sec.text = "%02d" % seconds
	if (minutes == 33 and seconds == 0):
		mini_boss_spwan()
