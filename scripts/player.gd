class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed

@export var dspeed = 100
@export var rate_of_fire := 0.25

@onready var muzzle = $Muzzle

var laser_scene = preload("res://scenes/laser.tscn")

var shoot_cd := false

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

func _physics_process(_delta):
	var game_node = get_node("/root/Game")
	var speed = game_node.speed
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 0)
	velocity = direction * speed
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 0, get_viewport_rect().size.x)

func shoot():
	laser_shot.emit(laser_scene, muzzle.global_position)

func die():
	killed.emit()
	queue_free()

func reduce_speed():
	var game_node = get_node("/root/Game")
	game_node.speed -= dspeed
	if game_node.speed<=0:
		die()

func increase_speed():
	var game_node = get_node("/root/Game")
	if game_node.speed<300:
		game_node.speed+=dspeed
