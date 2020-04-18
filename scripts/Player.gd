extends Node2D

signal give_apple
signal rescue
signal player_action_near_sq


var move_speed = 270
var near_sq = false

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


func give_apple():
	if near_sq:
		emit_signal("give_apple")


func _on_Sq_area_entered(area):
	near_sq = true


func _on_Sq_area_exited(area):
	near_sq = false
