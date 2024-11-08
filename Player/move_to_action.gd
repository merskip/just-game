class_name MoveToAction
extends Action

var target_position: Vector2
var movement_path := preload("res://Player/movement_path.tscn").instantiate()

func _init( _target_position: Vector2) -> void:
	self.target_position = _target_position
	icon = load("res://3rd party/tw-dnd/movement/walking.svg")

func start():
	unit.agent.target_position = target_position
	unit.humanoid_sprite.set_anim(HumanoidSprite.Anim.WALK)
	unit.walk_sfx.play()
	
	await unit.agent.path_changed
	movement_path.points = unit.agent.get_current_navigation_path()
	unit.get_tree().current_scene.add_child(movement_path)
	
	await unit.agent.navigation_finished
	unit.humanoid_sprite.set_anim(HumanoidSprite.Anim.IDLE)
	unit.walk_sfx.stop()
	finished.emit()

func dismiss():
	unit.humanoid_sprite.set_anim(HumanoidSprite.Anim.IDLE)
	unit.walk_sfx.stop()
	if movement_path != null:
		movement_path.queue_free()

func physics_process(_delta: float):
	var next_location = unit.agent.get_next_path_position()
	var direction = unit.global_position.direction_to(next_location)
	unit.velocity = direction * unit.speed
	unit.humanoid_sprite.direction = get_humanorid_sprite_direction(direction)
	unit.move_and_slide()
	unit.walk_sfx.pitch_scale = randf_range(0.8, 1.2)

func get_humanorid_sprite_direction(vector: Vector2) -> HumanoidSprite.Direction:
	if abs(vector.x) > abs(vector.y):
		return HumanoidSprite.Direction.RIGHT if vector.x > 0 else HumanoidSprite.Direction.LEFT
	else:
		return HumanoidSprite.Direction.DOWN if vector.y > 0 else HumanoidSprite.Direction.UP

func _to_string() -> String:
	return "MoveToAction(target_position=%s)" % target_position
