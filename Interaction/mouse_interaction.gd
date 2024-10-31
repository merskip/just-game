class_name MouseInteraction
extends Node2D

@export var interact_unit: Unit

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_update_mouse_cursor()
	elif event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		handle_interation()

func _update_mouse_cursor():
	var interaction = _get_interaction_under_mouser()
	if interaction:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func handle_interation():
	var interaction = _get_interaction_under_mouser()
	if interaction:
		print("interaction: " + interaction.to_string())
		interaction.interact(interact_unit)
		get_viewport().set_input_as_handled()

func _get_interaction_under_mouser() -> Interaction:
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
