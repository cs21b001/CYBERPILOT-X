extends Control

@onready var score = $Score:
	set(value):
		score.text = "Score: " + str(value)

@onready var shield = $Shield:
	set(value):
		shield.text = "Shield: " + str(value)

@onready var speed = $Speed:
	set(value):
		speed.text="Speed: " + str(value)
