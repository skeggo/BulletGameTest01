extends Node2D

@export var bullet_scn : PackedScene
@export var bullet_speed : float
@export var rpg_scn : PackedScene
var  fire_rate : float
var time_until_fire = 0.0
func _ready():
	fire_rate = 1/ Global.bps
func bullet_ins_four(direction):
	var bullet : RigidBody2D
	for i in range(2):
		bullet = bullet_scn.instantiate()
		bullet.rotation = rotation
		bullet.position = $muzzle.get_global_position()
		if i == 0:
			bullet.set_linear_velocity(bullet.transform.x * bullet_speed * direction)
		else:
			bullet.set_linear_velocity(bullet.transform.y * bullet_speed * direction)
		get_tree().root.add_child(bullet)
		Global.rotate_bullet += deg_to_rad(90)
func bullet_ins(direction):
	var bullet : RigidBody2D
	bullet = bullet_scn.instantiate()
	bullet.rotation = rotation
	bullet.position = $muzzle.get_global_position()
	bullet.set_linear_velocity(bullet.transform.x * bullet_speed * direction)
	get_tree().root.add_child(bullet)
func rpg_ins():
	var rpg : RigidBody2D
	rpg = rpg_scn.instantiate()
	rpg.rotation = rotation
	rpg.position = $muzzle2.get_global_position()
	rpg.set_linear_velocity(rpg.transform.x * -300)
	get_tree().root.add_child(rpg)
func _process(delta):
	fire_rate = 1/Global.bps
	var mouse_postion = get_global_mouse_position()
	look_at(mouse_postion)
	if (time_until_fire > fire_rate):
		var direction = 1
		if Global.four_direction:
			for i in range(2):
				bullet_ins_four(direction)
				direction *= -1
		else:
			bullet_ins(direction)
		time_until_fire = 0.0
	else:
		time_until_fire += delta
	if (Input.is_action_just_pressed("shoot")):
		rpg_ins()
