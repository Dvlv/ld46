extends Node2D


var move_speed = 270

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


