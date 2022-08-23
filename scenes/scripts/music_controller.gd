extends Node

var volume = 20

var music
var musics = [
	preload("res://sprites/Songs/space.mp3"),
	preload("res://sprites/Songs/space2.mp3"),
	preload("res://sprites/Songs/mixkit-space-game-668.mp3"),
	preload("res://sprites/Songs/No More Magic.mp3")
]

func play_music():
	$music.stream = music
	$music.play()

func stop():
	$music.stop()

func start():
	$Timer.start()

func _on_Timer_timeout():
	randomize()
	var  x = randi()%3+1
	music = musics[x]
	$music.stream = music
	$music.play()
	$Timer.stop()


func _on_music_finished():
	$Timer.start()
	return


func _on_splashTimer_timeout():
	randomize()
	var  x = randi()%3+1
	music = musics[x]
	$music.stream = music
	$music.play()

func _process(delta):
		$Volume/Volume.text = "Volume da musica: " + str(volume)
		if Input.is_action_just_pressed("-"):
			$Volume/Volume.visible = true
			if volume >0:
				$music.volume_db -=3
				volume -=1
				$VTimer.start()
			
		if Input.is_action_just_pressed("+"):
			$Volume/Volume.visible = true
			if volume <30:
				$music.volume_db +=3
				volume +=1
				$VTimer.start()

func _on_VTimer_timeout():
	$Volume/Volume.visible = false
	$VTimer.stop()
