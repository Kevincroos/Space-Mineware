extends Node2D

var hp = 0
var choosen = 0
onready var velY = rand_range(35, 180)
onready var velX = rand_range(-50, 50)
var knock_back = 0

signal destroyed(node)

var hps = [
	1,
	1,
	3,
	4,
	4
]

func _ready():
	randomize()
	for a in $asteroids.get_children():
		a.visible = false
	if not choosen:
		choosen = (randi() % $asteroids.get_child_count()) + 1
		
	hp = hps[choosen - 1]
	
	var node = get_node("asteroids/Asteroid-" + str(choosen))
	node.visible = true  
	
	$area/colission.shape.radius = node.texture.get_width() / 2
	
func _process(delta):
	
	translate(Vector2(velX, velY - knock_back) * delta)
	if global_position.x > 200:
		global_position.x = -40
	
	if global_position.x < -40:
		global_position.x = 200
	
	if global_position.y > 300:
		queue_free()
	
	if knock_back:
		knock_back = lerp(knock_back, 0, .1)
	
func _on_area_area_entered(area):
	hp -= 1
	knock_back = 200
	if not hp:
		destroy()
	else:
		get_tree().call_group("camera", "shake", .5)

func destroy():
	emit_signal("destroyed", self)
	get_tree().call_group("camera", "shake", 1)
	queue_free()

func get_hp_inicial():
	return hps[choosen - 1]

