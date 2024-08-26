extends Sprite2D

var period = 0.0

@export var radius :float =1000.0
var speed = 10.0


func _process(delta):
	period += delta
	position = radius * Vector2(sin(period * speed) , cos(period * speed))
