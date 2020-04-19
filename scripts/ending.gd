extends Node2D

onready var end = load("res://scenes/thanks.tscn")

var dialogue_step = -1

var dialogue = [
	"Blue: See, I told you he was no trouble at all",
	"Red: No you didn't, and yes he was!",
	"Blue: Don't sweat it dude",
	"Red: What even is that thing, anyway?",
	"Blue: Like, a frog or something.",
	"Blue: Anyway, thanks bro, See you same time tomorrow.",
	"Red: Noooooooooo!",


]


func _on_Button_pressed():
	dialogue_step += 1
	if dialogue_step >= dialogue.size():
		get_tree().change_scene_to(end)
	else:
		$NinePatchRect/Label.text = dialogue[dialogue_step]
