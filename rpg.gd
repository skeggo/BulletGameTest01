extends RigidBody2D

var pressed = false

func _ready():
	pass
func _process(delta):
	if !Global.paused and Input.is_action_just_pressed("shoot") and !pressed:
		pressed = true
		if $Area2D:
			$Timer.start()
			$Timer2.start()
			$Free_Timer.start()

func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy") || area.is_in_group("mini_boss"):	
		var enemy = area.owner
		enemy.enemy_health -= 1000
		if (enemy.enemy_health <= 0):
			Global.kill_count += 1
			Global.coin_count += 25
			enemy.queue_free()
		
func _on_timer_timeout():
	$AudioStreamPlayer2D.play()
	if $Area2D:
		$Area2D/CollisionShape2D.disabled = false
	$Sprite2D.hide()
	set_linear_velocity(Vector2.ZERO)
	$Sprite2D2.show()
	$Timer.stop()

func _on_free_timer_timeout():
	if $Area2D:
		$Area2D.queue_free()
	$Free_Timer.stop()


func _on_timer_2_timeout():
	queue_free()
	$Timer2.stop()
