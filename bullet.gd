extends Node2D



@export var player: Node2D
func _ready():
	$Sprite2D.rotation = Global.rotate_bullet
	
	
func _process(delta):
	$AnimationPlayer.play("bullet")

func _on_timer_timeout():
	queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy") || area.is_in_group("mini_boss"):	
		var enemy = area.owner
		enemy.enemy_health -= Global.bullet_damage
		if (enemy.enemy_health <= 0):
			Global.kill_count += 1
			Global.coin_count += 25
			enemy.queue_free()
		

