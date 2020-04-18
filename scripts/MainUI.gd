extends Control

onready var danger_tri = $GridContainer/warning/CenterContainer/TextureRect
onready var apple_label = $GridContainer/appleMeter/HB/LabCont/appleLabel
onready var main_text = $GridContainer/MarginContainer/CenterContainer/status



# Called when the node enters the scene tree for the first time.
func _ready():
	danger_tri.visible = false



func _on_Sq_in_danger(room):
	danger_tri.visible = true

	var new_text = ""

	if room == "bedroom":
		new_text = "Sq had found a box under your bed!"

	elif room == "kitchen":
		new_text = "Sq has set himself on fire!"

	elif room == "livingRoom":
		new_text = "The living room window has blown open!"

	elif room == "bathroom":
		new_text = "Sq is tangled up in the bath!"

	else:
		new_text = "Sq has damaged the electrical outlet!"

	main_text.text = new_text



func _on_Player_give_apple(near_sq):
	if danger_tri.visible:
		main_text.text += "\nHe doesn't want an apple right now!"
		return

	if near_sq:
		var rem_apples = int(apple_label.text)
		rem_apples -= 1

		apple_label.text = str(rem_apples)
		main_text.text = "Sq chomps delightfully on his delicious apple"

	else:
		main_text.text += "\nI need to be near him to give him an apple!"

func _on_Sq_moving_to_room(room):
	main_text.text = "Sq runs into the " + room


func _on_Sq_staying_in_room(room):
	var new_text = ""

	if room == "bedroom":
		new_text = "Sq wants to take a nap"

	elif room == "kitchen":
		new_text = "Sq can smell food in the fridge"

	elif room == "livingRoom":
		new_text = "Sq is watching TV"

	elif room == "bathroom":
		new_text = "Sq thinks he needs a bath"

	else:
		new_text = "Sq is charging his smartphone"

	main_text.text = new_text

func _on_Sq_rescued_from_danger(room):
	danger_tri.visible = false

	var new_text = ""

	if room == "bedroom":
		new_text = "You locked the box and hid it again."

	elif room == "kitchen":
		new_text = "You extinguished him just in time."

	elif room == "livingRoom":
		new_text = "You tied the window up again"

	elif room == "bathroom":
		new_text = "You untangled him and emptied the bath."

	else:
		new_text = "You shut off the power and plugged up the outlet."

	main_text.text = new_text