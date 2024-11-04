class_name Interaction
extends Node2D

@export var action_name: String = "Interact"
@export var max_distance: float = 100.0
@export var shape: Shape2D

func is_interactable(_unit: Unit) -> bool:
	return true
	
func can_interact(unit: Unit) -> bool:
	if not is_interactable(unit):
		return false
	var closest_point = get_closest_point(unit.global_position)
	return unit.global_position.distance_to(closest_point) <= max_distance

func interact(_unit: Unit):
	pass

func get_closest_point(from: Vector2) -> Vector2:
	if shape == null:
		return global_position
	
	var rect = shape.get_rect()
	rect.position += global_position
	return Vector2(
		clamp(from.x, rect.position.x, rect.position.x + rect.size.x),
		clamp(from.y, rect.position.y, rect.position.y + rect.size.y)
	)
