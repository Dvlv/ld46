extends Node2D

signal room_coords

var num_apples = 3

onready var sq = $Sq

onready var plug_danger_sprite = preload("res://assets/art/plug-danger.png")
onready var plug_normal_sprite = preload("res://assets/art/plug-normal.png")

onready var two_apples_sprite = preload("res://assets/art/counter2.png")
onready var one_apples_sprite = preload("res://assets/art/counter1.png")
onready var no_apples_sprite = preload("res://assets/art/counterempty.png")

onready var counter = $bgAssets/counter


func _ready():
	sq.connect("moving_to_room", self, "send_sq_room_coords")


func get_room_coords(room):
	if room == "kitchen":
		return $sqMovePoints/kitchen.position
	elif room == "bathroom":
		return $sqMovePoints/bathroom.position
	elif room == "hallway":
		return $sqMovePoints/hallway.position
	elif room == "bedroom":
		return $sqMovePoints/bedroom.position
	elif room == "livingRoom":
		return $sqMovePoints/livingRoom.position

	return $sqMovePoints/hallway.position


func send_sq_room_coords(room):
	var coords = get_room_coords(room)
	emit_signal("room_coords", coords)


func _on_Sq_in_danger(room):
	if room == "hallway":
		$bgAssets/plug.texture = plug_danger_sprite

func _on_Sq_rescued_from_danger(room):
	$bgAssets/plug.texture = plug_normal_sprite


func _on_Player_player_pick_up_apple():
	if num_apples > 0:
		num_apples -= 1

		if num_apples == 2:
			counter.texture = two_apples_sprite
		elif num_apples == 1:
			counter.texture = one_apples_sprite
		else:
			counter.texture = no_apples_sprite

	if num_apples == 0:
		$bgAssets/counter/appleArea.queue_free()

