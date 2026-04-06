extends Node

@export var markerArray: Array[Marker2D]
@export var area: Area2D
@export var animationPlayer: AnimationPlayer
@export var heartContainer: HBoxContainer
@export var points_label: Label
@export var jam_event: CanvasLayer
@export var jam_event_2: CanvasLayer
@export var camera: Camera2D
@export var main_audio: AudioStreamPlayer
@export var success_audio: AudioStreamPlayer
@export var lose_audio: AudioStreamPlayer
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	await get_tree().process_frame
	Talo.players.identify("playerone", "username")
	SignalBus.entered_light.connect(_lost_life)
	SignalBus.game_done.connect(move_task_to_random)
	move_task_to_random()
	for heart in heartContainer.get_children():
		heart.hide()
	for i in range(SignalBus.hp):
		heartContainer.get_child(i).show()
	points_label.text = str(SignalBus.points)
	main_audio.play()

func move_task_to_random():
	camera.apply_shake(0.0, false)
	points_label.text = str(SignalBus.points)
	if markerArray.is_empty():
		return
	area.hide()
	var random_marker = markerArray.pick_random()
	if random_marker.name == "Marker2D":
		area.rotation_degrees = 270;
	elif random_marker.name == "Marker2D3" || random_marker.name == "Marker2D5" ||random_marker.name == "Marker2D6":
		area.rotation_degrees = 90;
	elif random_marker.name == "Marker2D2":
		area.rotation_degrees = 180;
	elif random_marker.name == "Marker2D4":
		area.rotation_degrees = 0;
	area.global_position = random_marker.global_position
	await get_tree().create_timer(1.0).timeout
	area.show()


func _on_task_body_entered(body: Node2D) -> void:
	if SignalBus.still_jam:
		jam_event.show()
	elif SignalBus.still_jam_2:
		jam_event_2.show()
	else:
		SignalBus.jam_chance = rng.randi_range(1, 5)
		if body.name == "creature":
			if SignalBus.jam_chance == 1:
				jam_event.jam_event()
				camera.apply_shake(1.0, false)
			elif SignalBus.jam_chance == 2:
				jam_event_2._start_game()
			else:
				await get_tree().create_timer(1.0).timeout
				var bodies = area.get_overlapping_bodies()
				for aBody in bodies:
					if aBody.name == "creature":
						success_audio.play()
						SignalBus.points += 1
						points_label.text = str(SignalBus.points)
						move_task_to_random()

func _lost_life():
	jam_event._game_done()
	jam_event_2._game_done()
	get_tree().paused = true
	animationPlayer.play("caught")
	lose_audio.play()
	await animationPlayer.animation_finished
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	SignalBus.hp -= 1
	if SignalBus.hp <= 0:
		# var res := await Talo.leaderboards.add_entry("creatureG-leaderboard", SignalBus.points)
		# print("Added score: %s, at position: %s, new high score: %s" % [SignalBus.points, res.entry.position, "yes" if res.updated else "no"])
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		get_tree().reload_current_scene()
