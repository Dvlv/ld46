extends Node2D

signal moving_to_room
signal in_danger
signal staying_in_room
signal finished_apple
signal rescued_from_danger

var move_speed = 700
var destination_boundary = 50
var action_wait_time = 5.0

var move_destination = null
var current_room = null
var danger_cooldown = false
var is_in_danger = false
var is_eating_apple = false

onready var timer = $Timer
onready var danger_cd_timer = $dangerCooldownTimer
onready var danger_timer = $dangerTimer

func _ready():
	danger_cd_timer.connect("timeout", self, "on_danger_cd_timeout")
	danger_timer.connect("timeout", self, "on_danger_timeout")
	timer.connect("timeout", self, "random_action")
	timer.start()

func _physics_process(delta):
	if move_destination:
		var dist_from_pos_x = abs(move_destination.x - position.x)
		var dist_from_pos_y = abs(move_destination.y - position.y)
		if dist_from_pos_x > destination_boundary or dist_from_pos_y > destination_boundary:
			move_toward_destination(delta)
		else:
			move_destination = null


func move_toward_destination(delta):
	var x_mul = 1
	var y_mul = 1

	if position.x > move_destination.x:
		x_mul = -1

	if position.y > move_destination.y:
		y_mul = -1

	var move = Vector2(position.x + (move_speed * delta * x_mul), position.y + (move_speed * delta * y_mul))
	position = move

func random_action():
	var rooms = ["kitchen", "bathroom", "livingRoom", "bedroom", "hallway"]
	var actions = ["room", "danger"]

	randomize()

	if is_eating_apple:
		timer.wait_time = action_wait_time
		is_eating_apple = false
		emit_signal("finished_apple")
		$AnimatedSprite.play("idle")
		return

	var next_action = "room"

	if current_room and not danger_cooldown:
		next_action = actions[randi() % actions.size()]

	print(next_action)

	if next_action == "room":
		var next_room = rooms[randi() % rooms.size()]
		print(next_room)

		if next_room != current_room:
			emit_signal("moving_to_room", next_room)
			current_room = next_room
		else:
			emit_signal("staying_in_room", next_room)

	else:
		emit_signal("in_danger", current_room)
		is_in_danger = true
		danger_cooldown = true
		timer.paused = true
		danger_cd_timer.start()
		danger_timer.start()


func on_danger_cd_timeout():
	danger_cooldown = false
	timer.wait_time = 10.0
	timer.paused = false

	danger_timer.wait_time = 8.0
	danger_timer.paused = true

func on_danger_timeout():
	print("sq died in room", current_room)


func _on_Player_give_apple(near_sq):
	if is_in_danger:
		return

	if near_sq:
		print("yummy apple")
		$AnimatedSprite.play("apple")
		is_eating_apple = true

		timer.stop()
		timer.wait_time = 2 * action_wait_time
		timer.start()

		danger_cd_timer.wait_time = 20.0
		danger_cooldown = true
		danger_cd_timer.start()


func _on_Main_room_coords(coords):
	move_destination = coords


func _on_Player_rescue():
	is_in_danger = false
	danger_timer.paused = true
	danger_timer.wait_time = 8.0

	danger_cd_timer.start()
	danger_cooldown = true

	timer.paused = false
	timer.wait_time = 5.0

	emit_signal("rescued_from_danger", current_room)


func _on_Player_player_action_near_sq():
	if is_in_danger:
		_on_Player_rescue()
	else:
		print("player looks suspiciously at sq")
