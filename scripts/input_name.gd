extends Control

@onready var name_input = $LineEdit

func _ready():
	get_tree().paused = true # Stop the game
	name_input.grab_focus() # Auto-select the text box

func _on_submit_button_pressed():
	var username = name_input.text.strip_edges()
	
	if username == "":
		username = "Anonymous Creature"

	# 1. Identify the player in Talo with their chosen name
	# This links their session to this specific name
	await Talo.players.identify("guest", username)
	
	# 2. Submit the actual score
	var res := await Talo.leaderboards.add_entry("creatureG-leaderboard", SignalBus.points)
	print("Added score: %s, at position: %s, new high score: %s" % [SignalBus.points, res.entry.position, "yes" if res.updated else "no"])
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
