extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Transition.hide()
	$AnimationPlayer.play("game_over")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		$AnimationPlayer.stop()
		await get_tree().physics_frame
		$AnimationPlayer.play("going back")
		await get_tree().create_timer(1.5).timeout
		Transition.show()
		print("transition shows")
		await get_tree().create_timer(0.5).timeout
		print("transition changing")
		get_tree().call_deferred("change_scene_to_file", "res://scenes/start_screen.tscn")
