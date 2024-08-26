extends Control

@onready var player : CharacterBody2D = $"../../.."

var ball_scene = preload("res://circle_ability.tscn")

var paused = false

var ability_to_upgrade = []




var abilities = {
	1: ["BPS++", "increase_bps"],
	2: ["DAMAGE++","increase_bullet_damage"],
	3: ["SPEED++","increase_acceleration"],
	4: ["BALL++","spawn_ball"],
	5: ["PICKUP_RADIUS++", "increase_radius"]
}


func increase_bps():
	Global.bps +=2
func increase_bullet_damage():
	Global.bullet_damage += 5


func increase_acceleration():
	Global.acceleration += 25

func increase_radius():
	Global.pickup_radius += Vector2(0.2,0.2)

func get_random_upgrades():
	var rand = randi_range(1, abilities.size())
	for i in range(3):
		while(abilities[rand] in ability_to_upgrade):
			rand = randi_range(1, abilities.size())
			print("sd")
		ability_to_upgrade.append(abilities[rand])


func spawn_ball():
	if player:
		var ball = ball_scene.instantiate()
		player.add_child(ball)
		

func testEsc():
	if paused:
		$".".hide()
		Global.paused = false
		Engine.time_scale = 1
	else:
		get_random_upgrades()
		$MarginContainer/VBoxContainer/Choice1.text = ability_to_upgrade[0][0]
		$MarginContainer/VBoxContainer/Choice2.text = ability_to_upgrade[1][0]
		$MarginContainer/VBoxContainer/Choice3.text = ability_to_upgrade[2][0]
		$".".show()
		Global.paused = true
		Engine.time_scale = 0
	paused =!paused
		
		

	
func _process(delta):
	if Global.leveling >= Global.to_level_up and get_tree().paused == false:
		ability_to_upgrade = []
		Global.to_level_up = 100
		Global.leveling = 0
		testEsc()

func _on_choice_1_pressed():
	call(ability_to_upgrade[0][1])
	ability_to_upgrade = []
	testEsc()


func _on_choice_2_pressed():
	call(ability_to_upgrade[1][1])
	ability_to_upgrade = []
	testEsc()


func _on_choice_3_pressed():
	call(ability_to_upgrade[2][1])
	ability_to_upgrade = []
	testEsc()

