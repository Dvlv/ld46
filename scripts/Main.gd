extends Node2D

signal room_coords
signal no_more_mess

var num_apples = 3

onready var sq = $Sq

onready var plug_danger_sprite = preload("res://assets/art/plug-danger.png")
onready var plug_normal_sprite = preload("res://assets/art/plug-normal.png")

onready var two_apples_sprite = preload("res://assets/art/counter2.png")
onready var one_apples_sprite = preload("res://assets/art/counter1.png")
onready var no_apples_sprite = preload("res://assets/art/counterempty.png")

onready var counter = $bgAssets/counter

onready var end_hallway = preload("res://scenes/end-hallway.tscn")
onready var end_bathroom = preload("res://scenes/end-bathroom.tscn")
onready var end_bedroom = preload("res://scenes/end-bedroom.tscn")
onready var end_livingroom = preload("res://scenes/end-livingRoom.tscn")

onready var mess = $mess
onready var messLocs = $messLocations
onready var current_mess_loc = null
var house_is_clean = false


func _ready():
	sq.connect("moving_to_room", self, "send_sq_room_coords")
	$Player/AudioStreamPlayer.play()


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



func _on_Sq_game_over(room):
	var s = null

	if room == "hallway":
		s = get_tree().change_scene_to(end_hallway)
	elif room == "livingRoom":
		s = get_tree().change_scene_to(end_livingroom)
	elif room == "bathroom":
		s = get_tree().change_scene_to(end_bathroom)
	elif room == "bedroom":
		s = get_tree().change_scene_to(end_bedroom)
	else:
		s = get_tree().change_scene_to(end_livingroom)


func _on_Player_clean_up_mess(player_area):
	if house_is_clean:
		return

	var ml_children = messLocs.get_children()

	var has_more_locs = messLocs.get_child_count()

	if has_more_locs:
		randomize()
		var next_loc = ml_children[randi() % ml_children.size()]
		mess.position = next_loc.position
		current_mess_loc = next_loc
		print(next_loc.position)
	else:
		house_is_clean = true
		current_mess_loc = null
		mess.queue_free()
		get_tree().change_scene("res://scenes/ending.tscn")

	if current_mess_loc:
		current_mess_loc.queue_free()
		current_mess_loc = null





