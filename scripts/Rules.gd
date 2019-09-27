extends Node2D

export var time = 5
onready var timer = get_node("Timer")

func _ready():
	timer.wait_time = time
	timer.start()
	set_process(true)


func _process(delta):
	get_node("Camera2D/Label").text = "Timer" + " : " +str(int(timer.time_left))


func _on_Timer_timeout():
	get_tree().reload_current_scene()


func _on_Level1_body_entered(body):
	if body.name == "PlayerBody":
		get_node("Camera2D/AnimationPlayer").play("level1")
		get_node("Level1/CollisionShape2D").queue_free()


func _on_Level2_body_entered(body):
	if body.name == "PlayerBody":
		get_node("Camera2D/AnimationPlayer").play("level2")
		get_node("Level2/CollisionShape2D").queue_free()
