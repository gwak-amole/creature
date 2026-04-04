extends CharacterBody2D

@onready var screen_size = get_viewport().get_visible_rect().size
var speed = 150.0
var direction = Vector2.RIGHT

func _ready():
	randomize_behavior()
	
func _physics_process(delta):
	position += direction * speed * delta
	position.x = clamp(position.x, 130, 448)
	position.y = clamp(position.y, 32, 288)
	
	if position.x >= 448 || position.x <= 130:
		direction.x = -direction.x
	elif position.y >= 288 || position.y <= 32:
		direction.y = -direction.y

func randomize_behavior():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	speed = randf_range(100, 400)
	$PointLight2D.texture_scale = randf_range(0.5, 2.0)
	$Timer.wait_time = randi_range(1, 2)
	$Timer.start()
	

func _on_timer_timeout() -> void:
	randomize_behavior()
