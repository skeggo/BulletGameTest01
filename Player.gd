extends CharacterBody2D
var time_attack_boost : float = 3
var time_speed_boost : float = 3
var enemy_attacking
var health:float = 100
var time_splash : float = 2
@export var max_speed : float
@onready var axis = Vector2.ZERO
@export var friction : int = 600
var splash_scene = preload("res://splash_ability.tscn")
var splash_node




func spawn_splash():
	var splash = splash_scene.instantiate()
	splash.position = position
	get_tree().root.add_child(splash)
	splash_node = splash
func set_kill_count():
	$Kill_Count.text = "Kills :" + str(Global.kill_count)
func set_health_bar():
	$HealthBar.value = health
func set_level_count():
	$Level.max_value = Global.to_level_up
	$Level.value = Global.leveling
func _ready():
	$Pickupradius.scale = Global.pickup_radius
	$HealthBar.max_value = 100
	set_kill_count()
	$speed_Label.hide()
	$attack_boost_timer.hide()
	
func get_input():
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	axis = axis.normalized()
	if axis.x !=0:
		$Sprite2D.flip_h = (axis.x < 0)
	return axis

	
func _physics_process(delta):
	time_splash -= delta
	Global.player_position = position
	$Pickupradius.scale = Global.pickup_radius
	set_level_count()
	time_attack_boost -= delta
	$attack_boost_timer.text = "Time Left :" + "%02d" % fmod(time_attack_boost,60)
	time_speed_boost -= delta
	$speed_Label.text = "Time Left :" + "%02d" % fmod(time_speed_boost,60)
	set_kill_count()
	if enemy_attacking :
		health -= 10 * delta
	else:
		health = int(health)
	velocity = get_input() * Global.acceleration
	set_health_bar()
	move_and_slide()



func _on_enemy_check_area_entered(area):
	if area.is_in_group("consumables"):
		health += 10
	if area.is_in_group("attack_boost"):
		time_attack_boost = 3
		$attack_boost_timer.show()
		Global.bullet_damage = 20
		$attack_boost.start()
	if area.is_in_group("speed_boost"):
		time_speed_boost = 3
		$speed_Label.show()
		Global.acceleration += 200
		$speed_boost.start()
	if area.is_in_group("magnet"):
		Global.test = true
		$magnet_timer.start()
	if area.is_in_group("enemy"):
		enemy_attacking  = true



func _on_enemy_check_area_exited(area):
	enemy_attacking = false

func _on_attack_boost_timeout():
	Global.bullet_damage = 10
	$attack_boost_timer.hide()
	$attack_boost.stop()


func _on_speed_boost_timeout():
	Global.acceleration -= 200
	$speed_Label.hide()
	$speed_boost.stop()


func _on_pickupradius_area_entered(area):
	if area.is_in_group("XP"):
		Global.leveling += 25


func _on_magnet_timer_timeout():
	Global.test = false
	$magnet_timer.stop()


func _on_timer_splash_timeout():
	spawn_splash()
	$Free_splash.start()

func _on_free_splash_timeout():
	splash_node.queue_free()
