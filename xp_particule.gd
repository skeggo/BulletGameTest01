extends Node2D
@export var player : Node2D
var speed = 20
func _ready():
	pass


func _physics_process(delta):
	var movement = Vector2.ZERO
	if Global.test:
		movement = position.direction_to(Global.player_position)
		position += movement * speed

func _on_node_2d_area_entered(area):
	if area.is_in_group("pickup_radius"):
		queue_free()
