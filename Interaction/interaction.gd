class_name Interaction
extends Node2D

@export var action_name: String = "Interact"
@export var max_distance: float = 60.0

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
	var min_distance := INF
	var closest_point := global_position
	
	var collistion_object := _find_collision_object()
	for owner_id in collistion_object.get_shape_owners():
		for shape_id in range(collistion_object.shape_owner_get_shape_count(owner_id)):
			var shape = collistion_object.shape_owner_get_shape(owner_id, shape_id)
			
			var point = _get_closest_point_to_shape(from, shape)
			if from.distance_to(point) < min_distance:
				closest_point = point

	return closest_point

func _get_closest_point_to_shape(from: Vector2, shape: Shape2D) -> Vector2:
	var rect = shape.get_rect()
	rect.position += global_position
	return Vector2(
		clamp(from.x, rect.position.x, rect.position.x + rect.size.x),
		clamp(from.y, rect.position.y, rect.position.y + rect.size.y)
	)

func _find_collision_object() -> CollisionObject2D:
	for child in get_children():
		if child is CollisionObject2D:
			return child
	push_error("Not found collision object for interaction ", self)
	return null
