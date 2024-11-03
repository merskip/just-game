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
		var move_to_action = MoveToAction.new(interaction.global_position)
		if Input.is_key_pressed(KEY_SHIFT):
			interact_unit.add_action(move_to_action)
		else:
			interact_unit.set_action(move_to_action)
		
		var interact_action = InteractAction.new(interaction)
		interact_unit.add_action(interact_action)
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
