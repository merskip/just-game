class_name MoveToAction
extends Action

var agent: NavigationAgent2D
var target_position: Vector2
var movement_path := preload("res://Player/movement_path.tscn").instantiate()

func _init(_agent: NavigationAgent2D, _target_position: Vector2) -> void:
	self.agent = _agent
	self.target_position = _target_position
	icon = load("res://3rd party/tw-dnd/movement/walking.svg")

func start(unit: Unit):
	agent.target_position = target_position
	
	await agent.path_changed
	movement_path.points = agent.get_current_navigation_path()
	unit.get_tree().current_scene.add_child(movement_path)
	
	await agent.navigation_finished
	finished.emit()

func dismissed(_unit: Unit):
	if movement_path != null:
		movement_path.queue_free()

func physics_process(_delta: float, unit: Unit):
	var next_location = agent.get_next_path_position()
	var direction = unit.global_position.direction_to(next_location)
	unit.velocity = direction * unit.speed
	unit.move_and_slide()

func _to_string() -> String:
	return "MoveToAction(target_position=%s)" % target_position
