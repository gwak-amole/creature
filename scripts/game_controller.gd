extends Node

@export var markerArray: Array[Marker2D]
@export var area: Area2D
var points = 0

func _ready():
	SignalBus.entered_light.connect(_lost_life)
	move_task_to_random()

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
	
	await get_tree().create_timer(1.0).timeout
	area.global_position = random_marker.global_position
	area.show()


func _on_task_body_entered(body: Node2D) -> void:
	if body.name == "creature":
		points += 1
		move_task_to_random()

func _lost_life():
	print("haiay too long")
