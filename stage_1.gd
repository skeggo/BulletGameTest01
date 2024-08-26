extends Node2D
@export var player: CharacterBody2D
var enemy_load = preload("res://Enemy.tscn")
var time : float = 370.0
var minutes : int = 0
var seconds : int = 0
var mini_boss_load = preload("res://mini_boss.tscn")
var msec:int = 0
var time_to_inscrease_spawn : float  = 25.0
func spawn_increase_timer():
	time_to_inscrease_spawn = 25.0
	$Enemy_Spawner_Timer.wait_time -= 0.25
	$Mini_boss_spawner.wait_time -= 2
func _process(delta):
	time_to_inscrease_spawn -= delta
	if player.health <= 0:
		queue_free()
	time -= delta
	msec = fmod(time,1) / delta
	seconds = fmod(time,60)
	minutes = fmod(time,3600)/60
	$Player/Panel/Min.text = "%02d" % minutes
	$Player/Panel/Sec.text = "%02d" % seconds
	if time_to_inscrease_spawn <= 0:
		spawn_increase_timer()
	$Player/Coins.text = "Coins:" + "%02d" % Global.coin_count
func mini_boss_spwan():
	var mini_boss = mini_boss_load.instantiate()
	var enemy_spawner_postion = player.get_node("Enemy_Spawner").get_node("Sprite2D").get_global_position()
	mini_boss.position = enemy_spawner_postion
	add_child(mini_boss)
func _on_enemy_spawner_timer_timeout():
	var enemy = enemy_load.instantiate()
	var enemy_spawner_postion = player.get_node("Enemy_Spawner").get_node("Sprite2D").get_global_position()
	enemy.position = enemy_spawner_postion
	add_child(enemy)




func _on_mini_boss_spawner_timeout():
	mini_boss_spwan()
	$Mini_boss_spawner.start()

