extends Node2D
var time_splash : float = 1
func _physics_process(delta):
	$AnimationPlayer.play("splash")
func _process(delta):
	position = Global.player_position

func _on_area_2d_area_entered(area):
	var enemy = area.owner
	enemy.enemy_health -= 5
	if (enemy.enemy_health <= 0):
		Global.kill_count += 1
		Global.coin_count += 25
		enemy.queue_free()

