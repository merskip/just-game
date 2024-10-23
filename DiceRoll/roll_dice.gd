class_name RollDice
extends Node3D

enum DiceType {
	D4,
	D6,
	D8,
	D10,
	D12,
	D20
}

var _dices_types: Array[DiceType] = []
var _dices_bodies: Array[RigidBody3D] = []

@export var rotation_speed_max: float = 10.0
@onready var start_marker: Node3D = $StartPosition
@onready var roll_result_label := %RollResult
@onready var dice_roll_start_sfx: AudioStreamPlayer = $DiceRollStart
@onready var dice_rolling_sfx: AudioStreamPlayer = $DiceRolling

var _rolling_on_ground = false


var dices_scene := preload("res://DiceRoll/dices.tscn")

signal on_roll_result(value: int)

func _on_d4_button_pressed() -> void:
	add_dice(DiceType.D4)

func _on_d6_button_pressed() -> void:
	add_dice(DiceType.D6)

func _on_d8_button_pressed() -> void:
	add_dice(DiceType.D8)

func _on_d10_button_pressed() -> void:
	add_dice(DiceType.D10)

func _on_d12_button_pressed() -> void:
	add_dice(DiceType.D12)

func _on_d20_button_pressed() -> void:
	add_dice(DiceType.D20)

func add_dice(dice_type: DiceType):
	var dice_body = load_dice(dice_type)
	dice_body.get_parent().remove_child(dice_body)
	dice_body.global_position = start_marker.global_position
	dice_body.freeze = true
	add_child(dice_body)
	dice_body.sleeping_state_changed.connect(_on_dice_sleeping_state_changed.bind(dice_body))
	dice_body.body_entered.connect(_on_dice_body_entered)
	
	_dices_types.append(dice_type)
	_dices_bodies.append(dice_body)
	

func load_dice(dice_type: DiceType) -> RigidBody3D:
	var dices := dices_scene.instantiate()
	match dice_type:
		DiceType.D4:
			return dices.get_node("DiceD4")
		DiceType.D6:
			return dices.get_node("DiceD6")
		DiceType.D8:
			return dices.get_node("DiceD8")
		DiceType.D10:
			return dices.get_node("DiceD10")
		DiceType.D12:
			return dices.get_node("DiceD12")
		DiceType.D20:
			return dices.get_node("DiceD20")
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
	match dice_type:
		DiceType.D4:
			return "D4"
		DiceType.D6:
			return  "D6"
		DiceType.D8:
			return  "D8"
		DiceType.D10:
			return "D10"
		DiceType.D12:
			return "D12"
		DiceType.D20:
			return "D20"
		_:
			push_error("Unknown dice_type: %s" % dice_type)
			return ""

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

func _on_dice_sleeping_state_changed(dice_body: RigidBody3D) -> void:
	if dice_body.sleeping:
		var value := get_top_side_value(dice_body)
		on_roll_result.emit(value)
		dice_roll_start_sfx.stop()
		dice_rolling_sfx.stop()

func get_top_side_value(dice: RigidBody3D) -> int:
	var raycasts = dice.get_node("RayCasts").get_children()
	for raycast in raycasts:
		if raycast.is_colliding():
			return raycast.opposite_side
	return -1


func _on_dice_body_entered(_body: Node) -> void:
	if not _rolling_on_ground:
		_rolling_on_ground = true
		dice_rolling_sfx.play()
