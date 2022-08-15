extends CanvasLayer

var score =  0
var cristais = 0
var Hscore = 0

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
	"1",
	"2"
]

var pontos = [
	5000,
	10000,
	15000,
	20000,
	25000,
	30000,
	40000,
	50000,
	60000,
	70000,
	80000,
	90000,
	100000
]

func asteroid_destroyed(ast):
	var s = (6 - ast.choosen) * 11
	score += s
	$score.text = str(score)
	
	while score >= pontos[i] and i < 11:
		$pontuacao.text = messages[i]
		i +=1
	
	if i > 5:
		$anim.play("pontuacao")
	
