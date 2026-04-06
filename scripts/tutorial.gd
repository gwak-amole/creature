extends CanvasLayer
var messages = [
	"You are a creature, and you run a secret laundry business. ('e' key for next)",
	"You do it for your fellow monsters, but humans will do anything to destroy your business.",
	"Don't get caught by the light.",
	"If you get caught, you'll lose one of three lives. Lose all three and you're arrested.",
	"Use WASD or arrow keys to move.",
	"Oh yeah, sometimes the washing machines will jam. Try to work around that.",
	"Good luck!"
]
var current_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_tutorial()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("interact"):
		current_index += 1
		update_text()

func update_text():
	if current_index < messages.size():
		$Panel/Label.text = messages[current_index]
		$AnimationPlayer.play("step_" + str(current_index + 1))
	else:
		_finish_tutorial()

func start_tutorial():
	$AudioStreamPlayer.play()
	$Panel/Label.text = messages[current_index]
	$AnimationPlayer.play("step_1")

func _finish_tutorial():
	SignalBus.took_tutorial = true
	$AudioStreamPlayer.stop()
	get_tree().change_scene_to_file("res://scenes/main.tscn")
