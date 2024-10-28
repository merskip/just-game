class_name MouseMovement
extends Movement


@export var region: NavigationRegion2D
@export var speed := 200.0

@onready var agent := $"../NavigationAgent2D"
@onready var path_line := $"../../MovementPath"


func _ready() -> void:
	# Workaround: https://github.com/godotengine/godot/issues/84677
	set_physics_process(false)
	await NavigationServer2D.map_changed
	set_physics_process(true)
	
	agent.target_position = get_parent().global_position

func physics_process(_character_body: CharacterBody2D, _delta: float) -> void:
	if Input.is_action_pressed("MouseLeft"):
		agent.target_position = _character_body.get_global_mouse_position()
	
	if agent.is_navigation_finished():
		return
		
	var next_location = agent.get_next_path_position()
	var direction = _character_body.global_position.direction_to(next_location)
	_character_body.velocity = direction * speed
	_character_body.move_and_slide()

func _on_agent_path_changed() -> void:
	path_line.points = agent.get_current_navigation_path()
	path_line.visible = true

func _on_navigation_agent_2d_target_reached() -> void:
	path_line.visible = false
