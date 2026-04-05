extends ProgressBar

var time = 0.0
var thresh = 1.0
var change_progress = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = 0 # Replace with function body.
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (change_progress):
		time += delta
		if time < thresh:
			value = (time/thresh) * 100
		else:
			value = 100
			change_progress = false
			time = 0.0

func _on_task_body_exited(body: Node2D) -> void:
	if body.name == "creature":
		hide()
		time = 0.0
		value = 0.0
		change_progress = false

func _on_task_body_entered(body: Node2D) -> void:
	if body.name == "creature":
		show()
		change_progress = true
