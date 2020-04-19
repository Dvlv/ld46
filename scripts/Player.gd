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

		sprite.rotation_degrees = 0
		sprite.play("walk")

	elif Input.is_action_pressed("ui_down"):
		position.y += move_speed * delta
		sprite.rotation_degrees = 180
		sprite.play("walk")

	if Input.is_action_pressed("ui_left"):
		position.x -= move_speed * delta
		sprite.rotation_degrees = 270
		sprite.play("walk")

	elif Input.is_action_pressed("ui_right"):
		position.x += move_speed * delta
		sprite.rotation_degrees = 90
		sprite.play("walk")

	var is_acting = false


	if Input.is_action_just_pressed("player_action"):
		is_acting = true
		sprite.play("action")

		if near_sq:
			emit_signal("player_action_near_sq")
		elif is_near_apples and not has_apple:
			emit_signal("player_pick_up_apple")
			has_apple = true

	if Input.is_action_just_pressed("player_apple") and has_apple:
		is_acting = true
		sprite.play("action")
		emit_signal("give_apple", near_sq)
		has_apple = false

	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_down") \
	and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_right") \
	and (Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right")
	or Input.is_action_just_released("ui_up") or Input.is_action_just_released("ui_down")):
		sprite.play("idle")




func _on_Sq_area_entered(area):
	near_sq = true


func _on_Sq_area_exited(area):
	near_sq = false


func _on_appleArea_area_entered(area):
	is_near_apples = true


func _on_appleArea_area_exited(area):
	is_near_apples = false
