extends Node2D

export var scene_to_go = ""
var ready = 0
	
func _on_enviar_pressed():
	var text = str($scoreboard/login/name.text)
	SaveFile.saveGame(text)
	$scoreboard/login.visible = false
	$scoreboard/confirm.visible = true


func _on_no_pressed():
	$scoreboard/login.visible = true
	$scoreboard/confirm.visible = false


func _on_yes_pressed():
	var text = SaveFile.loadGame()
	$scoreboard/confirm.visible = false
	SaveFile.saveGame(text)
	scene_to_go = "res://scenes/main-menu.tscn"
	Transition.fade(scene_to_go)


func _on_CheckBox_toggled(button_pressed):
	if $scoreboard/login/name.text != "":
		$scoreboard/login/enviar.disabled = false
	
