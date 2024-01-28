class_name PauseMenu extends Control

@onready var Game = $"../../"




func _on_resume_pressed():
	Game.pauseMenu()


func _on_exit_pressed():
	get_tree().quit()
