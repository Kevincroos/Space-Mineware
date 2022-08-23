extends Node2D

onready var c = get_node("cenario/inimigos")
var vel = 20
var x = .0
signal morte(node)
export var scene_to_go = ""

export(NodePath) var lasers

const LOAD_LASER = preload("res://scenes/laser.tscn")
const LOAD_LASER2 = preload("res://scenes/laser.tscn")

func _ready():
	
	#SilentWolf.Scores.wipe_leaderboard()
	if lasers:
		lasers = get_node(lasers)
	else:
		lasers = get_parent()
	MusicController.stop()
	MusicController.start()
	name = SaveFile.loadGame()
	global.set_player_name(name)

func end():
	if $"HUD/minimap/mini-ship".global_position.y <= 92:
		c.safe_zone = true
		$HUD/minimap/marketplace.visible = true
	else:
		c.safe_zone = false
		$HUD/minimap/marketplace.visible = false

func _process(delta):
	
	#$Background.global_position = Vector2($ship.global_position.x - 140, $ship.global_position.y - 200)
	
	$HUD/minimap/distance.global_position.x = ($"HUD/minimap/mini-ship".global_position.x) - 21
	$HUD/minimap/distance.global_position.y = ($"HUD/minimap/mini-ship".global_position.y) - 3
	
	if $HUD/minimap/danger.visible == true:
			$HUD/minimap/distance/Label.add_color_override("font_color", Color.red)
	else:
			$HUD/minimap/distance/Label.add_color_override("font_color", Color.white)
		
	
	cheats()
	
	if $ship.hp_ship <= 0:
		$HUD/bonus.visible = false
		$Button.disabled = true
		$Background.pause_mode = Node.PAUSE_MODE_PROCESS
		$ship/dead_area.monitoring = false
		$ship.set_process(false)
		emit_signal("morte", self)
		$ship/hp/hp.text = "Game Over"
		$ship/morte.z_index = 0
		$ship/anim.play("morte")
		$ship/Ship.visible = false
		$ship/Spaceships.visible = false
		$cenario.visible = false
		$ship/dead_area.monitoring = false
		$ship/dead_area.monitorable = false
		$HUD/morte/score.text = str($HUD.score)
		$HUD/morte.visible = true
		$HUD/minimap.visible = false
		$HUD/danger_bar_zone.visible = false
		$HUD/safe_bar_zone.visible = false
		$HUD/progress_map.visible = false
		$HUD/score.visible = false
		$HUD/pontuacao.visible = false
	
	end()
	
	if Input.is_action_pressed("ui_cancel"):
		$HUD/goBack.visible = true
		get_tree().paused = true
		
	if $ship.hp_ship > 0:
		if $HUD/minimap.tempo <= 0 && $"HUD/minimap/mini-ship".global_position.y >= 0:
			$Planet.global_position.y += .3
		if get_tree().get_nodes_in_group("projeteis").size() == 10:
			$HUD/recarga/sprite.visible = true
		else:
			$HUD/recarga/sprite.visible = false

		if $Planet.global_position.y >= 400:
			$HUD.bonus += 1
			$"HUD/minimap/mini-ship".global_position.y = 240
			$Planet.global_position.y = -507

func _on_anim_animation_finished(morte):
	$ship/morte.visible = false

func _on_enviar_pressed():
	$HUD/ready/Timer.start()
	$HUD/ready.visible = false
	$HUD/ready/AnimationPlayer.play('tutorial')
	$HUD/minimap/marketplace/hp.disabled = false
	$HUD/minimap/marketplace/speed.disabled = false
	$HUD/minimap/marketplace/laser.disabled = false
	$HUD/minimap/marketplace/friend.disabled = false
	$HUD/minimap.ready = true

func _on_scores_pressed():
	MusicController.play_music()
	SilentWolf.Scores.persist_score(global.player_name, $HUD.score)
	SilentWolf.Scores.get_high_scores()
	yield(get_tree().create_timer(.7), 'timeout')
	scene_to_go = "res://addons/silent_wolf/Scores/Leaderboard.tscn"
	Transition.fade(scene_to_go)

func _on_sair_pressed():
	MusicController.play_music()
	scene_to_go = "res://scenes/main-menu.tscn"
	Transition.fade(scene_to_go)

func _on_jogar_pressed():
	scene_to_go = "res://scenes/game.tscn"
	Transition.fade(scene_to_go)

func restartTimer():
	$HUD/minimap/distance/clock.start()

func _on_clock_timeout():
	x+=.1
	$HUD/minimap/distance/Label.text = str(x)+" Km"
	restartTimer()

func friendShip():
	$ship/Ship.hframes = 1
	$HUD/minimap/marketplace/friend.disabled = true

func gunUpdate():
	$ship.gun = 20
	$HUD/minimap/marketplace/laser.disabled = true

func hpPlus():
	$ship.hp_ship += 10
	$ship/hp/hp.text = str($ship.hp_ship)
	$HUD/minimap/marketplace/hp.disabled = true

func speed():
	$ship.vel = 55
	$ship.vel2 = 140
	$HUD/minimap/marketplace/speed.disabled = true

func _on_speed_pressed():
	speed()

func cheats():
	if Input.is_action_pressed("x"):
		pass
	if Input.is_action_pressed("1"):
		$ship/Spaceships.visible = true
		$ship/Ship.visible = false
		$ship/Spaceships.frame+=1
		if $ship/Spaceships.frame >= 14:
			$ship/Spaceships.visible = false
			$ship/Ship.visible = true
			$ship/Spaceships.frame = 0
	if Input.is_action_pressed("z"):
		pass
	if Input.is_action_pressed("T"):
		$ship/shield.visible = true

func _on_yes_pressed():
	SilentWolf.Scores.persist_score(global.player_name, $HUD.score)
	SilentWolf.Scores.get_high_scores()
	scene_to_go = "res://scenes/main-menu.tscn"
	Transition.fade(scene_to_go)
	get_tree().paused = false

func _on_no_pressed():
	get_tree().paused = false
	$HUD/goBack.visible = false


func _on_hp_pressed():
	hpPlus()


func _on_friend_pressed():
	friendShip()


func _on_laser_pressed():
	gunUpdate()

func _on_up_pressed():
	$ship.global_position.y += -10

func _on_down_pressed():
	$ship.global_position.y += 10


func _on_right_pressed():
	$ship.global_position.x += 10


func _on_left_pressed():
	$ship.global_position.x += -10


func _on_fire_pressed():
	$ship/laser.play()
	if get_tree().get_nodes_in_group("projeteis").size() < $ship.gun:
		var laser = LOAD_LASER.instance()
		lasers.add_child(laser)
		laser.global_position = $ship/blaster1.global_position
		var laser2 = LOAD_LASER2.instance()
		lasers.add_child(laser2)
		laser2.global_position = $ship/blaster2.global_position
	


func _on_enviar2_pressed():
	$HUD/ready/Timer.start()
	$HUD/ready.visible = false
	$HUD/ready/AnimationPlayer.play('tutorial')
	$HUD/minimap/marketplace/hp.disabled = false
	$HUD/minimap/marketplace/speed.disabled = false
	$HUD/minimap/marketplace/laser.disabled = false
	$HUD/minimap/marketplace/friend.disabled = false
	$HUD/minimap.ready = true
	$HUD/ready/AnimationPlayer.play('tutorial')


func _on_Timer_timeout():
	$HUD/ready/Timer.stop()
	$HUD/minimap.tempo = -1
	$cenario/inimigos.ready = true
	$HUD/minimap/distance/clock.start()


func _on_Button_pressed():
	pass # Replace with function body.


func _on_pause_pressed():
		$HUD/goBack.visible = true
		get_tree().paused = true
