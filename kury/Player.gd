extends KinematicBody2D

var speed = 400
var x = 0
var y = 0
var dir = Vector2(0, 1)
onready var shuriken = preload("res://shuriken/Shuriken.tscn")
var is_throwing = false
var ammo = 99


func _ready():
	set_process(true)
	set_process_input(true)
	

func reload(cont):
	ammo = cont

	

func _input(event):
	if event.is_action_pressed("ui_shuriken"):
		if not is_throwing and ammo > 0:
			shuriken()
		else:
			pass


func _process(delta):
	if Input.is_action_pressed("ui_down"):
		y = 1
	
	if Input.is_action_pressed("ui_up"):
		y = -1

	if Input.is_action_pressed("ui_left"):
		x = -1
		
	if Input.is_action_pressed("ui_right"):
		x = 1
	
	if x != 0 or y != 0 :	
		move(x, y)
	elif is_throwing:
		get_node("AnimatedSprite").play("throw")
	else :
		get_node("AnimatedSprite").play("idle")
	x = 0
	y = 0
		
		
func move(x, y):
	dir = Vector2(x,y)
	dir = dir.normalized()
	rotation_degrees = rad2deg(dir.angle()) - 90
	get_node("AnimatedSprite").play("walk")
	move_and_slide(dir * speed)
	

func shuriken():
	var i_shuriken = shuriken.instance()
	get_parent().add_child(i_shuriken)
	get_node("AnimatedSprite").play("throw")
	i_shuriken.set_position(position + dir * 30)
	i_shuriken.get_node("KinematicBody2D").direction = dir
	is_throwing = true
	ammo -= 1 
	$Timer.start()

	
func die():
	get_tree().reload_current_scene()


func _on_Timer_timeout():
	is_throwing = false
