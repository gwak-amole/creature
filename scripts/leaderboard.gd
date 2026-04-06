extends Control

@export var row_template: PackedScene # Drag LeaderboardRow.tscn here
@onready var list = $ScrollContainer/Leaderboardlist

func _ready():
	$AudioStreamPlayer.play()
	var options := Talo.leaderboards.GetEntriesOptions.new()
	var res := await Talo.leaderboards.get_entries("creatureG-leaderboard", options)
	
	for child in list.get_children():
		child.queue_free()
		
	for entry in res.entries:
		var row = row_template.instantiate()
		list.add_child(row)
		
		var username = "Guest"
		if entry.player_alias:
			username = entry.player_alias.identifier # Use identifier to be safe
			
		row.set_row(username, entry.score)


func _on_button_pressed() -> void:
	$AudioStreamPlayer.stop()
	Transition.show()
	get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
