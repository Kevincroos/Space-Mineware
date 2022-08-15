extends Node2D

const PRE_ASTEROID = preload("res://scenes/asteroid.tscn")
const PRE_EXPLOSION = preload("res://scenes/explosion.tscn")
const PRE_CRISTAL = preload("res://scenes/cristais.tscn")

var safe_zone = false
var ready = false

export(NodePath) var nave

func _ready():
	restartTimer()

func _on_spawn_timer_timeout():
	if safe_zone == false && ready == true:
		var ast = create_asteroid()
		add_child(ast)
		ast.global_position = Vector2(rand_range(asteroidZone.global_position.x, asteroidZone.global_position.x/2), -21)
		restartTimer()

func restartTimer():
	$spawn_timer.wait_time = rand_range(.5, 1)
	$spawn_timer.start()

func on_asteroid_destroyed(ast):
	if ast.choosen >= 3:
		for a in range((randi() % 2) + 2):
			var new_ast = create_asteroid()
			new_ast.choosen = (randi() % 2) + 1
			add_child(new_ast)
			new_ast.global_position = ast.global_position
	get_tree().call_group("hud", "asteroid_destroyed", ast)
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = ast.global_position

	for a in range(ast.get_hp_inicial()):
		var c = PRE_CRISTAL.instance()
		add_child(c)
		c.global_position = ast.global_position

func create_asteroid():
	var ast = PRE_ASTEROID.instance()
	ast.connect("destroyed", self, "on_asteroid_destroyed")
	return ast
