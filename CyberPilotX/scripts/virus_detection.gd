extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_continue_pressed():
	var game_node = get_node("/root/Game")
	game_node.vdet.visible = false
	Engine.time_scale = 1
