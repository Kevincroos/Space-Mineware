extends Node2D

export var scene_to_go = ""
var time = 3
var forca = 3
var splashes = [
	
	"32 players :D",
	"Colab?",
	"XDDDDDD",
	"On-Line!",
	"x + y = xy",
	"Octavius",
	"Me dê minha caixa!",
	"Godot 3",
	"Bug free...",
	"</>",
	"Não me hackeie!",
	"U(ser) I(nterface)",
	"x + 9 = not me",
	"Estude JavaScript;",
	"/op Cleiton"
]
var account = SaveFile.loadGame()
var logged = false

func _ready():
	if account != "":
		$menu/loadGame.visible = true
	$menu/player.text = SaveFile.loadGame()
	if account == "":
		$menu/scoreboard/login.visible = true
	randomize()
	$menu/splash_text.text = splashes[randi() % splashes.size()]

func _process(delta):
	
	time -= delta * 1
	$Planet.global_position = Vector2(forca+20, forca+20).rotated(time)
	forca = lerp(forca, 10, .1)
	
	if not account == "":
		logged = true
	
func _on_play_pressed():
	if logged == true:
		scene_to_go = "res://scenes/game.tscn"
		Transition.fade(scene_to_go)
	
func _on_options_pressed():
	if logged == true:
		scene_to_go = "res://scenes/options.tscn"
		Transition.fade(scene_to_go)
	
func _on_exit_pressed():
	if logged == true:
		get_tree().quit()
	

func _on_enviar_pressed():
	scene_to_go = "res://scenes/createAccount.tscn"
	Transition.fade(scene_to_go)
