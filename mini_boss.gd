extends CharacterBody2D

@export var speed: float
@export var player : Node2D
@export var enemy_health : float  = 1000.0
var unloaded_scene : String =  Global.get_random_consumbale_mini_boss()
var consumable_scene
var unloaded_xpscene : String = Global.xp_gain()
var xp_scene


func _ready():
	consumable_scene = load(unloaded_scene)
	xp_scene = load(unloaded_xpscene)
	player = get_parent().get_node("Player")
	$HealthBar.max_value = 1000


func spawn_consumable():
	var consumable = consumable_scene.instantiate()
	consumable.position = position
	get_tree().root.add_child(consumable)	
	
func set_health_bar():
	$HealthBar.value = enemy_health

func spawn_xp_mini_boss():
	var chance = randi_range(5,20)
	for i in range(chance):
		var xp = xp_scene.instantiate()
		xp.position = position + Vector2(randf_range(0,50),randf_range(0,50))
		get_tree().root.add_child(xp)

func _physics_process(delta):
	velocity = position.direction_to(player.position) * speed
	set_health_bar()
	if (enemy_health <= 0):
		Global.coin_count += 25
		spawn_consumable()
		spawn_xp_mini_boss()
	move_and_slide()

