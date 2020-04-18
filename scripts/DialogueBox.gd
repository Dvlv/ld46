extends Control

signal finished_displaying

onready var TIMER = $Timer
onready var NAME = $VBoxContainer/MarginContainer4/NinePatchRect/Name
onready var TEXT = $VBoxContainer/MarginContainer4/NinePatchRect/Text
onready var ACCEPT = $VBoxContainer/MarginContainer4/NinePatchRect/Accept

var listening = false

func _ready():
    ACCEPT.visible = false
    TIMER.connect("timeout", TEXT, "_on_Timer_timeout")

func _process(delta):
    if listening:
        if Input.is_action_just_released("ui_accept"):
            ACCEPT.visible = false
            TEXT.visible_characters = 0
            self.visible = false
            listening = false
            emit_signal("finished_displaying")

func set_name(name):
    NAME.text = name

func set_text(text):
    TEXT.text = text

func display_text():
    TIMER.start()

func show_dialogue(name, text):
    self.visible = true
    listening = false
    ACCEPT.visible = false

    set_name(name)
    set_text(text)
    display_text()

func dialogue_finished_callback():
    TIMER.stop()
    ACCEPT.visible = true
    listening = true