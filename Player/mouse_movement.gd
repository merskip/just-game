class_name MouseMovement
extends Movement


@export var region: NavigationRegion2D
@export var speed := 200.0

@onready var unit: Unit = $".."

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		var target_position = region.get_global_mouse_position()
		var action = MoveToAction.new(target_position)
		unit.add_or_set_action(action)
		get_viewport().set_input_as_handled()
