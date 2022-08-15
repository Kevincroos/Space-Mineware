extends Node2D

var PRE_IMPACT  = preload("res://scenes/impact.tscn")

var vel = 200

func _ready():
	pass 

func _process(delta):
	translate(Vector2(0, -1) * vel * delta)



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_area_area_entered(area):
	$blaster.play()
	var i = PRE_IMPACT.instance()
	get_parent().add_child(i)
	i.global_position = global_position
	visible = false
