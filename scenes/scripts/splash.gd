extends Node2D

var time = 0
export var scene_to_go = ""

func _ready():
	pass
	$Timer.start()
	$Timer2.start()
	
func _process(delta):
	
	if time > 0 && $"mini-ship".global_position.y >= -770 && $"Asteroid-3".global_position.y <= 770:
		$"mini-ship".global_position.y -= 8
		$"Asteroid-3".global_position.y += 8
	
	if $"mini-ship".global_position.y >= -140 && $"Asteroid-3".global_position.y >= 140:
		$logo.visible = true
		$logo2.visible = true
	
	if $"mini-ship".global_position.y >= -770 && $"Asteroid-3".global_position.y >= 770:
		$"mini-ship2".global_position.y += 7.5
	if $"mini-ship2".global_position.y >= 115:
		$"mini-ship2".global_position.y = 115
		
	if $"mini-ship2".global_position.y >= 115:
		set_process(false)
		$AudioStreamPlayer.play()

func _on_Timer_timeout():
	time += 1



func _on_Timer2_timeout():
	queue_free()
	scene_to_go = "res://scenes/main-menu.tscn"
	Transition.fade(scene_to_go)
