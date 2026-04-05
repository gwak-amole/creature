extends CanvasLayer
@export var first_button_group: VBoxContainer
@export var second_button_group: VBoxContainer
var rng = RandomNumberGenerator.new()
var button_press = 0
var all_buttons = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()
	all_buttons.append_array(first_button_group.get_children())
	all_buttons.append_array(second_button_group.get_children())
	for button in all_buttons:
		button.toggle_mode = true
	_game_done()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		hide()
	
func jam_event():
	SignalBus.still_jam = true
	$AnimationPlayer.play("text")
	button_press = 0
	
	for button in all_buttons:
		button.disabled = true
		button.button_pressed = false
	
	var choose = 0
	while choose < 3:
		var rand_button = all_buttons.pick_random()
		if rand_button.disabled == true:
			rand_button.disabled = false
			choose += 1
	show()

		

func _game_done():
	SignalBus.still_jam = false
	for button in all_buttons:
		button.disabled = true
		button.button_pressed = false
	button_press = 0
	$AnimationPlayer.stop()
	hide()


func _on_texture_button_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		button_press += 1
		if button_press == 3:
			_game_done()
	else:
		button_press -=1
