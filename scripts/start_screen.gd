extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	Transition.hide()
	$CanvasModulate.color = Color.BLACK
	
	SignalBus.hp = 3
	SignalBus.points = 0
	
	$AnimationPlayer.play("boot_up")
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("start_screen")
	$menu.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		$menu.stop()
		$AnimationPlayer.stop()
		await get_tree().physics_frame
		$AnimationPlayer.play("going_in")
		await $AnimationPlayer.animation_finished
		get_tree().change_scene_to_file("res://scenes/main.tscn")
