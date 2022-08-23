extends Node2D

var tempo = 3.0
signal end(node)
var time = 0
var ready = false
var galaxias = [
	"Galáxia Bergollus",
	"Galáxia Solos",
	"Sistema planetário Imunus",
	"Galáxia Exploit",
	"Constelação Ransom"
	
]
var planetas = [
	"Planeta Solunus",
	"Planeta Coruscant",
	"Planeta anão Ircana",
	"Planeta Cravinus",
	"Planeta Torus"
]
var cinturao = [
	"Cinturão de asteroides F-11",
	"Cinturão de asteroides A-44",
	"Cinturão de asteroides D-89",
	"Cinturão de asteroides Z-40",
	"Cinturão de asteroides O-01",
]

var i = rand_range(0, cinturao.size())

var p = rand_range(0, planetas.size())

func _ready():
	pass
	
func _process(delta):
	randomize()
	if tempo <= 0 && $"mini-ship".global_position.y >= 72:
		$"mini-ship".global_position.y -= .08
		
	if $"mini-ship".global_position.y >= 233 && ready == true:
		$marketplace/hp.disabled = false
		$marketplace/speed.disabled = false
		$marketplace/laser.disabled = false
		$marketplace/friend.disabled = false

	if $"mini-ship".global_position.y <= 92:
		emit_signal("end")
	else:
		pass
	if $"mini-ship".global_position.y <= 72:
		safe_zone()
		$zoneAlert.visible = true
		$zoneAlert.text = planetas[i]
	else:
		$safe_zone.visible = false
		$stop_safe.visible = false
	
	if $"mini-ship".global_position.y <= 144 && $"mini-ship".global_position.y >= 90:
		danger_zone()
		$zoneAlert.visible = true
		$zoneAlert.text = cinturao[i]
		blink()
		$anim.play("new_zone")
		
	else:
		$danger.visible = false
	
func danger_zone():
		$spawn_timer.wait_time = rand_range(.1, .4)
		$spawn_timer.start()

func safe_zone():
	$safe_zone.visible = true
	$stop_safe.visible = true
	$anim.play("new_zone")

func blink():
	$danger.visible = true
	if $danger.visible == true:
		time += 1
	if time >= 0 && time <= 50:
		$danger.visible = true
	else:
		$danger.visible = false
	if time >= 100:
		time = 0
	


func _on_anim_animation_finished(new_zone):
	pass


func _on_dangerZone_timeout():
	danger_zone()
