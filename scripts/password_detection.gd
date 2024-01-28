extends Control



func _on_continue_pressed():
	var game_node = get_node("/root/Game")
	game_node.password_detection.visible = false
	Engine.time_scale = 1
