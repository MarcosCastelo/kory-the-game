extends KinematicBody2D

var speed = 1000
var direction = Vector2(0,0) setget _set_direction

func _set_direction(value):
	direction = value
		
func _ready():
	set_process(true)
	
func _process(delta):
	move_and_slide(direction * speed)


	
