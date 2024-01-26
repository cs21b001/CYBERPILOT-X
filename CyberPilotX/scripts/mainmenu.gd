class_name Mainmenu extends Control
@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var start_game = preload("res://scenes/game.tscn") as PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	start.button_down.connect(_on_start_button_down)
	exit.button_down.connect(_on_exit_button_down )


func _on_start_button_down():
	get_tree().change_scene_to_packed(start_game)


func _on_exit_button_down():
	get_tree().quit()
