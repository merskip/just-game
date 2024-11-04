class_name Interaction
extends Node2D

@export var action_name: String = "Interact"
@export var max_distance: float = 100.0

func is_interactable(_unit: Unit) -> bool:
	return true
	
func can_interact(unit: Unit) -> bool:
	if not is_interactable(unit):
		return false
	return unit.global_position.distance_to(global_position) <= max_distance

func interact(_unit: Unit):
	pass
