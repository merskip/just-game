extends Node3D

@export var rotation_speed_max: float = 10.0
@onready var dice: RigidBody3D = %Dice
@export var raycasts: Array[DiceSideRayCast]
var _start_position: Vector3

signal on_roll(value: int)

func _ready() -> void:
	_start_position = dice.position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		roll()

func roll() -> void:
	dice.position = _start_position
	dice.rotation = Vector3(randf_range(-2 * PI, 2 * PI),
							randf_range(-2 * PI, 2 * PI),
							randf_range(-2 * PI, 2 * PI))
	dice.angular_velocity = Vector3(randf_range(-rotation_speed_max, rotation_speed_max),
									randf_range(-rotation_speed_max, rotation_speed_max),
									randf_range(-rotation_speed_max, rotation_speed_max))
	dice.freeze = false

func _on_dice_sleeping_state_changed() -> void:
	if dice.sleeping:
		var value = get_top_side_value()
		print("You rolled: %s" % value)
		on_roll.emit(value)

func get_top_side_value() -> int:
	for raycast in raycasts:
		if raycast.is_colliding():
			return raycast.opposite_side
	return -1
