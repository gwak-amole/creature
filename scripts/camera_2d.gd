extends Camera2D
var shake_strength = 0.0
var shake_decay = 5.0
var max_offset = Vector2(20,15)
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()

func _process(delta):	
	offset = get_random_offset()

func get_random_offset():
	return Vector2(
		rng.randf_range(-shake_strength, shake_strength),
		rng.randf_range(-shake_strength, shake_strength)
		
	)
	
func apply_shake(strength: float):
	shake_strength = strength

# Called every frame. 'delta' is the elapsed time since the previous frame.
