extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(_delta: float) -> void:
	var move = Vector3(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down"),
		0
	).normalized()
	velocity.x = move.x * speed
	velocity.y = move.y * speed

	move_and_slide()
