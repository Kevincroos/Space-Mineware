extends CanvasLayer

var score =  0
var cristais = 0
var Hscore = 0
var bonus = 1
var bscore = 11

var CRISTAIS = preload("res://scenes/cristais.tscn")

var i = 0

var messages = [
	"Wow!",
	"Coletor de lixo",
	"Nave civil",
	"Destruidor desconhecido",
	"Nave de corrida",
	"destruidor do espaço",
	"Caçador de recompensas",
	"Uma lenda?",
	"Cyclone!",
	"Meu player favorito^^",
	"Infinity Runner",
	"--Voyager 2--",
	"---Voyager 1---",
	"",
	""
]

var pontos = [
	2000,
	5000,
	10000,
	15000,
	20000,
	25000,
	30000,
	35000,
	40000,
	45000,
	50000,
	55000,
	60000,
	65000,
	70000
]

func asteroid_destroyed(ast):
	var s = (6 - ast.choosen) * bscore
	score += s
	$score.text = str(score)
	
	while score >= pontos[i] and i < 13:
		$pontuacao.text = messages[i]
		i +=1
	
	if i > 5:
		$anim.play("pontuacao")
	
func _process(delta):
	if score > 0:
		if bonus >= 2:
			bscore = bonus*11
			$bonus.text = str(bonus) + "X"
			$bonus.visible = true
			$AnimationPlayer.play("bonus")
		else:
			bscore = 11
			$bonus.visible = false


func _on_speed_pressed():
	bonus = 0


func _on_hp_pressed():
	bonus = 0


func _on_friend_pressed():
	bonus = 0


func _on_laser_pressed():
	bonus = 0
