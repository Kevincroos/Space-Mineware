extends Node2D

var path = "user://save.txt"
var player_name = ""

func _ready():
	pass
	
func _process(delta):
	pass

func loadGame():
	var file = File.new()
	file.open(path, File.READ)
	var textFile = file.get_as_text()
	file.close()
	print('Jogo carregado!')
	return textFile

func saveGame(data):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(data)
	file.close()
	print('Jogo salvo!')

func _on_Button_pressed():
	$Label.text = loadGame()


func _on_Button2_pressed():
	var text = str($word.text)
	saveGame(text)
