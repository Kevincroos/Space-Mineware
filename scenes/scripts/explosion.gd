extends Node2D

func _ready():
	pass


func _process(delta):
	pass



func _on_anim_animation_finished(explosao1):
	visible = false
	queue_free()

