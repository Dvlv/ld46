extends Node2D

onready var main_scene = load("res://scenes/Main.tscn")

func _on_Button_pressed():
	get_tree().change_scene_to(main_scene)
