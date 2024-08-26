extends Node2D


func _on_area_2d_area_entered(area):
	var enemy = area.owner
	enemy.enemy_health -= Global.bullet_damage
	if (enemy.enemy_health <= 0):
		Global.kill_count += 1
		Global.coin_count += 25
		enemy.queue_free()
		
