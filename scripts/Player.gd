extends Node2D

signal give_apple
signal player_action_near_sq
signal player_pick_up_apple


var move_speed = 270
var near_sq = false
var is_near_apples = false
var has_apple = false

onready var sprite = $AnimatedSprite

func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		position.y -= move_speed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y += move_speed * delta

	if Input.is_action_pressed("ui_left"):
		position.x -= move_speed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += move_speed * delta

	if Input.is_action_just_pressed("player_action"):
		if near_sq:
			emit_signal("player_action_near_sq")
		elif is_near_apples and not has_apple:
			emit_signal("player_pick_up_apple")
			has_apple = true

	if Input.is_action_just_pressed("player_apple") and has_apple:
		emit_signal("give_apple", near_sq)
		has_apple = false



func _on_Sq_area_entered(area):
	near_sq = true


func _on_Sq_area_exited(area):
	near_sq = false


func _on_appleArea_area_entered(area):
	is_near_apples = true


func _on_appleArea_area_exited(area):
	is_near_apples = false
