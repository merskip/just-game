class_name PlayerMovement
extends Movement

@export var speed: float = 300.0

func physics_process(character_body: CharacterBody2D, _delta: float) -> void:
	var move = Vector3(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down"),
		0
	).normalized()
	character_body.velocity.x = move.x * speed
	character_body.velocity.y = move.y * speed

	character_body.move_and_slide()
