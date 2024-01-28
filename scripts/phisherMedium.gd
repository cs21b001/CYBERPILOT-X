class_name PhiserMedium extends Area2D

signal killed(points)
signal hit

@export var speedx = 150
@export var speedy = 100
@export var hp = 2
@export var points = 200
@export var shield_damage = 2


func _physics_process(delta):
	global_position.y += speedy * delta
	global_position.x += speedx * delta
	if global_position.x < 0 or global_position.x > get_viewport().size.x:
		speedx *= -1

func die():
	queue_free()

func _on_body_entered(body):
	var game_node = get_node("/root/Game")
	if game_node.phisher_collision == 0 :
		game_node.phisher_collision += 1
		Engine.time_scale = 0
		game_node.phisher_detection.visible = true
		
	if body is Player:
		body.reduce_speed()
	die()

func _on_visible_on_screen_notifier_2d_screen_exited():
	var game_node = get_node("/root/Game")
	game_node.score -= 500
	if game_node.score < 500:
		game_node._on_player_killed()
	queue_free()

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		killed.emit(points)
		die()
	else:
		hit.emit()

func _on_area_entered(area):
	var game_node = get_node("/root/Game")
	if area is Shield and game_node.shield:
		if game_node.shield < shield_damage:
			game_node.shield = 0
		else:
			game_node.shield -= shield_damage
		queue_free()
