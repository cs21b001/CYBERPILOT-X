extends Control

@onready var start_game = preload("res://scenes/game.tscn") as PackedScene
# Called when the node enters the scene tree for the first time.



func _on_continue_pressed():
	get_tree().change_scene_to_packed(start_game)
