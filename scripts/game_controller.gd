extends Node

@export var markerArray: Array[Marker2D]
@export var area: Area2D
@export var animationPlayer: AnimationPlayer
@export var heartContainer: HBoxContainer
@export var points_label: Label

func _ready():
	SignalBus.entered_light.connect(_lost_life)
	move_task_to_random()
	for heart in heartContainer.get_children():
		heart.hide()
	for i in range(SignalBus.hp):
		heartContainer.get_child(i).show()

func move_task_to_random():
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
	if body.name == "creature":
		SignalBus.points += 1
		points_label.text = str(SignalBus.points)
		move_task_to_random()

func _lost_life():
	get_tree().paused = true
	animationPlayer.play("caught")
	await animationPlayer.animation_finished
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false
	SignalBus.hp -= 1
	if SignalBus.hp <= 0:
		var game_over = true
	else:
		get_tree().reload_current_scene()
