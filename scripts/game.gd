extends Node2D

@export var enemy_scenes: Array[PackedScene] = []
@export var phisher_scenes: Array[PackedScene] = []
@export var antivirus_scenes: Array[PackedScene] = []
@export var password_scenes: Array[PackedScene] = []

@onready var level_2 = $UILayer/Level2
@onready var player_spawn_pos = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var antivirustimer = $AntivirusSpawnTimer
@onready var passwordtimer = $PasswordSpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var antivirus_container = $AntivirusContainer
@onready var password_container = $PasswordContainer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOverScreen
@onready var vdet = $UILayer/Virus_detection
@onready var pb = $ParallaxBackground
@onready var pause_menu = $UILayer/PauseMenu
@onready var laser_sound = $SFX/LaserSound
@onready var hit_sound = $SFX/HitSound
@onready var explode_sound = $SFX/ExplodeSound
@onready var antivirus_detection_2 = $UILayer/Antivirus_detection2
@onready var password_detection = $UILayer/password_detection
@onready var phisher_detection = $UILayer/phisher_detection

@export var password_score=1000

var paused = false
var player = null
var shield := 0:
	set(value):
		shield = value
		if shield < 0:
			shield = 0
		$Shield.visible = shield > 0
		hud.shield = shield

var speed := 0:
	set(value):
		speed = value
		if speed < 0:
			speed = 0
		hud.speed = speed

var score := 0:
	set(value):
		score = value
		if score <0:
			score = 0
		hud.score = score
var high_score
var scroll_speed = 0
var first_level= true
@export var second_level= false
@export var first_collision:int = 0
@export var antivirus_collision:int = 0
@export var phisher_collision:int = 0
@export var password_collision:int = 0
func _ready():
	pause_menu.visible = false
	level_2.visible = false
	antivirus_detection_2.visible = false
	password_detection.visible = false
	
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	score = 0
	shield = 0 
	speed = 300
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("Pause"):
		pauseMenu()
	
	if timer.wait_time > 0.5:
		timer.wait_time -= delta*0.005
	elif timer.wait_time < 0.5:
		timer.wait_time = 0.5
	
	pb.scroll_offset.y += delta*scroll_speed
	if pb.scroll_offset.y >= 960:
		pb.scroll_offset.y = 0

func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = ! paused

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	laser_sound.play()

func _on_enemy_spawn_timer_timeout():
	if first_level == true:
		var e = enemy_scenes.pick_random().instantiate()
		e.global_position = Vector2(randf_range(50, 500), -50)
		e.killed.connect(_on_enemy_killed)
		e.hit.connect(_on_enemy_hit)
		enemy_container.add_child(e)

func _on_enemy_killed(points):
	if score >= password_score and second_level == false:
		level_2.visible = true
		Engine.time_scale = 0
		first_level = false
		second_level= true
	hit_sound.play()
	score += points
	if score > high_score:
		high_score = score

func _on_enemy_hit():
	hit_sound.play()

func _on_player_killed():
	var tscore = score
	explode_sound.play()
	gos.set_score(tscore)
	gos.set_high_score(high_score)
	save_game()
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
	Engine.time_scale = 0


func _on_antivirus_spawn_timer_timeout():
	var a = antivirus_scenes.pick_random().instantiate()
	a.global_position= Vector2(randf_range(30,510), -50)
	antivirus_container.add_child(a)


func _on_password_spawn_timer_timeout():
	if second_level == true:
		var a = password_scenes.pick_random().instantiate()
		a.global_position= Vector2(randf_range(30,510), -50)
		password_container.add_child(a)


func _on_phisher_spawn_timer_timeout():
	if second_level == true:
		var p = phisher_scenes.pick_random().instantiate()
		p.global_position = Vector2(randf_range(30, 510), -50)
		p.killed.connect(_on_enemy_killed)
		p.hit.connect(_on_enemy_hit)
		enemy_container.add_child(p)
