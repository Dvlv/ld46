extends Node2D

onready var main_scene = load("res://scenes/tutorial.tscn")

var dialogue_step = -1

var dialogue = [
	"Red: Uh, no?",
	"Blue: Haha, sure you do. Anyway, I need you to watch Merlin for about six hours.",
	"Red: What, no. I have to clean up around here.",
	"Blue: Ah, don't worry about it. He'll be good. He's just gonna look around your house a bit.",
	"Blue: He can phase through walls so he doesn't make loud footsteps",
	"Blue: And if he gets too excited, just give him an apple and he'll calm down",
	"Blue: Well gotta run, thanks buddy, see you in six.",
	"Red: ... Great.",
]


func _on_Button_pressed():
	dialogue_step += 1
	if dialogue_step >= dialogue.size():
		get_tree().change_scene_to(main_scene)
	else:
		$NinePatchRect/Label.text = dialogue[dialogue_step]
