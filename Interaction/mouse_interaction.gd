class_name MouseInteraction
extends Node2D

@export var interact_unit: Unit

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_update_mouse_cursor()
	elif event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		handle_interation()

func _update_mouse_cursor():
	var interaction = _get_interaction_under_mouse()
	if interaction:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func handle_interation():
	var interaction = _get_interaction_under_mouse()
	if interaction == null:
		return
	var distance = interact_unit.global_position.distance_to(interaction.global_position)
	if distance > interaction.max_distance:
		var interact_position = get_position_at_distance(
			interact_unit.global_position,
			interaction.global_position,
			interaction.max_distance - interact_unit.agent.path_desired_distance)
		var move_to_action = MoveToAction.new(interact_position)
		interact_unit.add_or_set_action(move_to_action)
	
	var interact_action = InteractAction.new(interaction)
	interact_unit.add_action(interact_action)
	get_viewport().set_input_as_handled()

func _get_interaction_under_mouse() -> Interaction:
	var spaceState = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.collide_with_areas = true
	query.position = get_global_mouse_position()
	var results = spaceState.intersect_point(query)
	
	for result in results:
		var collider: Node2D = result["collider"]
		var interaction: Interaction
		if collider is Interaction:
			interaction = collider as Interaction
		if collider.get_parent() is Interaction:
			interaction = collider.get_parent() as Interaction
		
		if interaction != null and interaction.is_interactable(interact_unit):
			return interaction
	return null

func get_position_at_distance(start: Vector2, target: Vector2, distance: float) -> Vector2:
	var direction = (start - target).normalized()
	return target + direction * distance
