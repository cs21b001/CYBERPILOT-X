class_name Antivirus extends Area2D
@export var speedy= 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position.y += speedy * delta
	
func die():
	queue_free()
	

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_body_entered(body):
	var game_node = get_node("/root/Game")
	if game_node.antivirus_collision == 0 :
		game_node.antivirus_collision += 1
		game_node.antivirus_detection_2.visible = true
		Engine.time_scale = 0
	if body is Player:
		body.increase_speed()
	die()
