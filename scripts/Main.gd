extends Node2D

signal room_coords

onready var sq = $Sq

# Called when the node enters the scene tree for the first time.
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

