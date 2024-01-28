extends Control


# Called when the node enters the scene tree for the first time.
func _on_continue_pressed():
	var game_node = get_node("/root/Game")
	game_node.level_2.visible = false
	Engine.time_scale = 1
