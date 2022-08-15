extends Camera2D

var time = 3
var forca = 3

func _ready():
	pass


func _process(delta):
	time += delta * 3
	global_position = Vector2(forca, forca).rotated(time)
	forca = lerp(forca, 2, .1)
