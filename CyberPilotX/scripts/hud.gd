extends Control

@onready var score = $Score:
	set(value):
		score.text = "Score: " + str(value)


@onready var player_life = $player_life:
	set(value):
		player_life.text = "Lives: " + str(value)
