extends CanvasLayer
@export var progress: ProgressBar
@export var camera: Camera2D
@export var success_audio: AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_game_done()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if visible == true:
		if progress.value > 0:
			progress.value -= 0.5
		if Input.is_action_just_pressed("interact"):
			camera.apply_shake(1.0, true)
			$AnimationPlayer.play("insert")
			progress.value += 10
	if progress.value == 100:
		SignalBus.points += 1
		success_audio.play()
		_game_done()

func _game_done():
	progress.value = 0
	SignalBus.game_done.emit()
	SignalBus.still_jam_2 = false
	hide()

func _start_game():
	show()
	SignalBus.still_jam_2 = true
	$AnimationPlayer2.play("text")

func _on_task_body_exited(body: Node2D) -> void:
	if body.name == "creature":
		hide()
