extends CharacterBody2D

@export var speed: float
@export var player : Node2D
@export var enemy_health : float  = 100.0
var unloaded_scene : String =  Global.get_random_consumbale_enemy()
var unloaded_xpscene : String = Global.xp_gain()
var consumable_scene
var xp_scene
var freezed = false
var normal_speed
func _ready():
	consumable_scene = load(unloaded_scene)
	player = get_parent().get_node("Player")
	xp_scene = load(unloaded_xpscene)
	normal_speed = speed
func spawn_xp_enemy():
	var chance = randi_range(1,10)
	for i in range(chance):
		var xp = xp_scene.instantiate()
		xp.position = position + Vector2(randf_range(0,50),randf_range(0,50))
		get_tree().root.add_child(xp)

func spawn_consumable():
	var consumable = consumable_scene.instantiate()
	consumable.position = position
	get_tree().root.add_child(consumable)

func _physics_process(delta):
	velocity = position.direction_to(player.position) * speed
	if (enemy_health <= 0):
		Global.coin_count += 5
		spawn_consumable()
		spawn_xp_enemy()
	if (freezed):
		speed = 10
	else:
		speed = normal_speed
	move_and_slide()



func _on_effect_hitbox_area_entered(area):
	if !area.is_in_group("enemy"):
		freezed = true


func _on_effect_hitbox_area_exited(area):
	if !area.is_in_group("enemy"):
		freezed = false
