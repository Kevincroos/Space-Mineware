extends Node2D

export var vel = 35.0
var vel2 = 170.0
var shield = 100.0
var hp_ship = 10
var time = 0
var game_over = 1
var gun = 10

var play_with_mouse = false

export(NodePath) var lasers

const LOAD_LASER = preload("res://scenes/laser.tscn")
const LOAD_LASER2 = preload("res://scenes/laser.tscn")

func _ready():
	if lasers:
		lasers = get_node(lasers)
	else:
		lasers = get_parent()

func _process(delta):
	
	var x = 0
	var y = 0
	var HudArea = 190
	var target = get_global_mouse_position()
	
	if play_with_mouse == true:
		if global_position.distance_to(target) > 4 and target.y < 250:
			translate(global_position.direction_to(target) * vel2 * delta)
	
	if hp_ship > 0:
	
		if Input.is_action_just_pressed("ui_accept") || Input.is_action_just_pressed("mouse_left"):
			$laser.play()
			if get_tree().get_nodes_in_group("projeteis").size() < gun:
				var laser = LOAD_LASER.instance()
				lasers.add_child(laser)
				laser.global_position = $blaster1.global_position
				var laser2 = LOAD_LASER2.instance()
				lasers.add_child(laser2)
				laser2.global_position = $blaster2.global_position
	
		if Input.is_action_pressed("ui_left"):
			x += -3
	
		if Input.is_action_pressed("ui_right"):
			x += 3
	
		if Input.is_action_pressed("ui_up"):
			y += -3
			
	
		if Input.is_action_pressed("ui_down"):
			y += 3
	
	translate(Vector2(x, y) * vel * delta)
	
	global_position.x = clamp(global_position.x, 21, 139)
	
	global_position.y = clamp(global_position.y, 21, 265)
	
	
func _on_Area2D_area_entered(area):
	if area.get_parent().has_method("destroy"):
		area.get_parent().destroy()
	if [4].find(area.collision_layer) >= 0:
		get_tree().call_group("camera", "shake", 1)
		shield -= .35
		if $Area2D.monitorable == true:
			$impact2.play()
	var proporcao = shield / 100.0

func _on_dead_area_area_entered(area):
	if area.get_parent().has_method("destroy"):
		hp_ship -= 1
		$impact.play()
		$hp/hp.text = str(hp_ship)
		if hp_ship <= 0:
			$game_over.start()
	
	
func _on_game_over_timeout():
	if game_over == 1:
		time += 1
		$hp/hp.visible = not $hp/hp.visible


func _on_enviar2_pressed():
	play_with_mouse = true
