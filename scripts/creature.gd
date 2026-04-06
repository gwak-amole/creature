extends CharacterBody2D
@export var speed = 200.0

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		$AnimatedSprite2D.play("walking")
		if direction.x > 0:
			$AnimatedSprite2D.flip_h = true
		elif direction.x <0:
			$AnimatedSprite2D.flip_h = false
		velocity = direction * speed
	else:
		$AnimatedSprite2D.play("idle")
		velocity = Vector2.ZERO
	
	move_and_slide()
		
