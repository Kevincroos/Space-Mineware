extends Node2D

var vel = 0.0
var dir = Vector2()
var rot = 0
var target = null
var cristal_vel = 200.0
var frame = 0
var die = false

func _ready():
	randomize()
	var frames = $cristal.hframes * $cristal.vframes
	$cristal.frame = randi() % frames
	vel = rand_range(90, 130)
	dir = Vector2(rand_range(-1, 1) , rand_range(-1, 1))
	rot = rand_range(-10, 10)

func _process(delta):
	frame += 1
	if not die:
		if target:
			translate(global_position.direction_to(target.global_position) * cristal_vel * delta)
		else:
			translate(dir * vel * delta)
		rotate(rot * delta)

func _on_Area2D_area_entered(area):
	$cristal2.play()
	$cristal.queue_free()
	$Area2D.queue_free()
	die = true


func _on_Timer_timeout():
	var players = get_tree().get_nodes_in_group("player")
	if players.size():
		target = players[0]


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
