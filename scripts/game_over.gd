extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("game_over")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		$AnimationPlayer.stop()
		await get_tree().physics_frame
		$AnimationPlayer.play("going back")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://scenes/start_screen.tscn")
