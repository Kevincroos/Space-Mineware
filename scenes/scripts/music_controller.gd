extends Node

var music = load("res://sprites/Songs/space.mp3")

func _ready():
	pass

func play_music():
	$music.stream = music
	$music.play()

func stop():
	$music.stop()

