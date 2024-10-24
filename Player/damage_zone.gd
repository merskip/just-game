extends Node2D

@export var damage: int = 10

func _on_body_entered(body: Node2D) -> void:
	if body is Unit:
		body.take_damage(damage)
