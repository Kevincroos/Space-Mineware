extends CanvasLayer

var scene_to_go = ""
onready var animation = $anim

func fade(scene):
	scene_to_go = scene
	animation.play("fade")
	
	
func change_scene():
 get_tree().change_scene(scene_to_go)
