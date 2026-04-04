extends CharacterBody2D

@onready var screen_size = get_viewport().get_visible_rect().size
var speed = 50.0
var direction = Vector2.RIGHT
var max_speed = 300.0
var min_speed = 50.0
var timer = 0.0
var threshold = 250.0

func _ready():
	randomize_behavior()
	
func _process(delta):
	timer += delta
	if (timer > threshold && max_speed < 500.0):
		min_speed += 50
		max_speed += 50
		print("increased")
		timer = 0.0
	
func _physics_process(delta):
	position += direction * speed * delta
	position.x = clamp(position.x, 160, 418)
	position.y = clamp(position.y, 65, 255)
	
	if position.x >= 418 || position.x <= 160:
		direction.x = -direction.x
	elif position.y >= 255 || position.y <= 65:
		direction.y = -direction.y

func randomize_behavior():
	direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	speed = randf_range(min_speed, max_speed)
	var theScale = randf_range(0.5, 2.0)
	$PointLight2D.texture_scale = theScale
	$Area2D/CollisionShape2D.shape.radius = 32 * theScale
	$Timer.wait_time = randi_range(1, 2)
	$Timer.start()
	

func _on_timer_timeout() -> void:
	randomize_behavior()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "creature":
		await get_tree().create_timer(0.4).timeout
		var bodies = $Area2D.get_overlapping_bodies()
		for aBody in bodies:
			if aBody.name == "creature":
				SignalBus.entered_light.emit()
