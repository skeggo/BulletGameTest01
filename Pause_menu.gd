extends Control


var paused = false

func pauseMenu():
	if paused:
		$".".hide()
		Engine.time_scale = 1
	else:
		$".".show()
		Engine.time_scale = 0
	paused =!paused
	
func _process(delta):
	if Input.is_action_just_pressed("echap"):
		pauseMenu()
	





func _on_resume_pressed():
	pauseMenu()


func _on_quit_pressed():
	get_tree().quit()
