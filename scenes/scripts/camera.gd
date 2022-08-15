extends Camera2D

var time = 0
var forca = 0
var y = 0

func _ready():
	pass


func _process(delta):
	
	if forca > 0:
		time += delta * 100
		global_position = Vector2(forca, forca).rotated(time)
	
	forca = lerp(forca, 0, .1)
	if Input.is_action_just_pressed("ui_cancel"):
		shake(2)
	
func go_up():
	if global_position.y <= 350:
		y -= 2
		global_position = Vector2(0, y)
	
func shake(v):
	if forca < 2:
		forca += v
	else:
		forca = 2
