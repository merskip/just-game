class_name RollDice
extends Node3D

enum DiceType {
	D4 = 4,
	D6 = 6,
	D8 = 8,
	D10 = 10,
	D12 = 12,
	D20 = 20,
	D100 = 100
}

var _dices_types: Array[DiceType] = []
var _dices_bodies: Array[RigidBody3D] = []

@export var rotation_speed_max: float = 10.0
@onready var start_marker: Node3D = $StartPosition
@onready var roll_result_label := %RollResult
@onready var dice_roll_start_sfx: AudioStreamPlayer = $DiceRollStart
@onready var dice_rolling_sfx: AudioStreamPlayer = $DiceRolling

var _rolling_on_ground = false

@onready var _dice_d4 := $Dices/DiceD4
@onready var _dice_d6 := $Dices/DiceD6
@onready var _dice_d8 := $Dices/DiceD8
@onready var _dice_d10 := $Dices/DiceD10
@onready var _dice_d12 := $Dices/DiceD12
@onready var _dice_d20 := $Dices/DiceD20
@onready var _dice_d100 := $Dices/DiceD100

signal on_roll_result(dices: Array[DiceType], values: Array[int])

func add_dice(dice_type: DiceType):
	var dice_body = duplicate_dice(dice_type)
	add_child(dice_body)
	dice_body.freeze = true
	dice_body.global_position = start_marker.global_position
	dice_body.sleeping_state_changed.connect(_on_dice_sleeping_state_changed.bind(dice_body))
	dice_body.body_entered.connect(_on_dice_body_entered)
	
	_dices_types.append(dice_type)
	_dices_bodies.append(dice_body)
	

func duplicate_dice(dice_type: DiceType) -> RigidBody3D:
	match dice_type:
		DiceType.D4:
			return _dice_d4.duplicate()
		DiceType.D6:
			return _dice_d6.duplicate()
		DiceType.D8:
			return _dice_d8.duplicate()
		DiceType.D10:
			return _dice_d10.duplicate()
		DiceType.D12:
			return _dice_d12.duplicate()
		DiceType.D20:
			return _dice_d20.duplicate()
		DiceType.D100:
			return _dice_d100.duplicate()
		_:
			push_error("Unknown dice_type: %s" % dice_type)
			return null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		roll()
		
func _process(_delta: float) -> void:
	roll_result_label.text = ""
	for i in range(_dices_types.size()):
		var dice_type := _dices_types[i]
		var dice_body := _dices_bodies[i]
		
		var dice_value = get_top_side_value(dice_body)
		roll_result_label.text += dice_name(dice_type) + ": "
		
		if dice_body.sleeping:
			roll_result_label.text += "rolled %s\n" % [dice_value]
		elif dice_value != -1:
			roll_result_label.text += "%s (rolling)\n" % dice_value
		else:
			roll_result_label.text += "? (rolling)\n"


func dice_name(dice_type: DiceType) -> String:
	return "D%s" % dice_type

func roll() -> void:
	_rolling_on_ground = false
	for dice_body in _dices_bodies:
		_roll_dice(dice_body)
	dice_roll_start_sfx.play()

func _roll_dice(dice_body: RigidBody3D):
	dice_body.position = start_marker.position
	dice_body.rotation = Vector3(randf_range(-2 * PI, 2 * PI),
								 randf_range(-2 * PI, 2 * PI),
								 randf_range(-2 * PI, 2 * PI))
	dice_body.angular_velocity = Vector3(randf_range(-rotation_speed_max, rotation_speed_max),
										 randf_range(-rotation_speed_max, rotation_speed_max),
										 randf_range(-rotation_speed_max, rotation_speed_max))
	dice_body.freeze = false

func _on_dice_sleeping_state_changed(_dice_body: RigidBody3D) -> void:
	if all_dices_sleeping():
		dice_rolling_sfx.stop()
		var values = _dices_bodies.map(func(dice): return get_top_side_value(dice))
		print("Roll values: D", _dices_types, " -> ", values)
		on_roll_result.emit(_dices_types, values)


func get_top_side_value(dice: RigidBody3D) -> int:
	var raycasts = dice.get_node("RayCasts").get_children()
	for raycast in raycasts:
		if raycast.is_colliding():
			return raycast.opposite_side
	return -1

func all_dices_sleeping() -> bool:
	for dice_body in _dices_bodies:
		if not dice_body.sleeping:
			return false
	return true

func _on_dice_body_entered(_body: Node) -> void:
	if not _rolling_on_ground:
		_rolling_on_ground = true
		dice_rolling_sfx.play()
