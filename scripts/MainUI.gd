extends Control

onready var danger_tri = $GridContainer/warning/CenterContainer/TextureRect
onready var apple_label = $GridContainer/appleMeter/HB/LabCont/appleLabel
onready var main_text = $GridContainer/MarginContainer/CenterContainer/status



# Called when the node enters the scene tree for the first time.
func _ready():
	danger_tri.visible = false

func _on_Sq_in_danger(room):
	danger_tri.visible = true
	$GridContainer/warning/CenterContainer/TextureRect/AnimationPlayer.play("flash")

	var new_text = ""

	if room == "bedroom":
		new_text = "Merlin has found a box under your bed!"

	elif room == "livingRoom":
		new_text = "The living room window has blown open!"

	elif room == "bathroom":
		new_text = "Merlin is tangled up in the bath!"

	else:
		new_text = "Merlin has damaged the electrical outlet!"

	main_text.text = new_text



func _on_Player_give_apple(near_sq):
	if danger_tri.visible:
		main_text.text += "\nHe doesn't want an apple right now!"
		return

	if near_sq:
		apple_label.text = "0"
		main_text.text = "Merlin chomps excitedly on his delicious apple"

	else:
		main_text.text += "\nI need to be near him to give him an apple!"

func _on_Sq_moving_to_room(room):
	main_text.text = "Merlin runs into the " + room


func _on_Sq_staying_in_room(room):
	var new_text = ""

	if room == "bedroom":
		new_text = "Merlin wants to take a nap"

	elif room == "livingRoom":
		new_text = "Merlin is watching TV"

	elif room == "bathroom":
		new_text = "Merlin thinks he needs a bath"

	else:
		new_text = "Merlin is charging his smartphone"

	main_text.text = new_text

func _on_Sq_rescued_from_danger(room):
	danger_tri.visible = false
	$GridContainer/warning/CenterContainer/TextureRect/AnimationPlayer.stop()

	var new_text = ""

	if room == "bedroom":
		new_text = "You lock the box and hide it again."


	elif room == "livingRoom":
		new_text = "You tie the window up again"

	elif room == "bathroom":
		new_text = "You untangle him and empty the bath."

	else:
		new_text = "You shut off the power and reset the outlet."

	main_text.text = new_text

func _on_Player_player_pick_up_apple():
	apple_label.text = "1"


func _on_Sq_finished_apple():
	main_text.text = "Merlin has eaten his apple. Burp."


func _on_Main_no_more_mess():
	main_text.text = "That's it, the house is clean!!"


func _on_Player_clean_up_mess(p):
	main_text.text += "\n\nAnother mess taken care of."
