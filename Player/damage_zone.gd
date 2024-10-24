extends Node2D

@export var damage: int = 10

func _on_body_entered(body: Node2D) -> void:
	var unit: Unit = body.get_node_or_null("Unit")
	if unit:
		unit.take_damage(damage)
