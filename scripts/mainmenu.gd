class_name Mainmenu extends Control
@onready var start = $MarginContainer/HBoxContainer/VBoxContainer/Start as Button
@onready var exit = $MarginContainer/HBoxContainer/VBoxContainer/Exit as Button
@onready var start_screen = preload("res://scenes/Start.tscn") as PackedScene



func _on_start_button_down():
	get_tree().change_scene_to_packed(start_screen)


func _on_exit_button_down():
	get_tree().quit()
