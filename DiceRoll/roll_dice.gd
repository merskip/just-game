class_name RollDice
extends Node3D

enum DiceType {
	D4,
	D6,
	D8,
	D10,
	D12,
	D20,
	D100
}

@export var dice_type: DiceType = DiceType.D6
@export var rotation_speed_max: float = 10.0
@onready var start_marker: Node3D = $StartPosition
@onready var label := $CanvasLayer/Label

var _rolling_on_ground = false
var dice: RigidBody3D

signal on_rolling_on_ground()
signal on_roll_result(value: int)

func _ready() -> void:
	var new_dice = load_dice()
	new_dice.get_parent().remove_child(new_dice)
	new_dice.global_position = start_marker.global_position
	new_dice.freeze = true
	add_child(new_dice)
	new_dice.sleeping_state_changed.connect(_on_dice_sleeping_state_changed)
	dice = new_dice

func load_dice() -> RigidBody3D:
	var dices = preload("res://DiceRoll/dices.tscn").instantiate()
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
		DiceType.D100:
			return dices.get_node("DiceD100")
	return null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		roll()
		
func _process(_delta: float) -> void:
	var top_side = get_top_side_value()
	
	label.text = "Rolled value: %s" % top_side
	if dice.sleeping:
		label.text += " (finished)\n"
	else:
		label.text += " (rolling)\n"
	

func roll() -> void:
	dice.freeze = true
	dice.position = start_marker.position
	dice.rotation = Vector3(randf_range(-2 * PI, 2 * PI),
							randf_range(-2 * PI, 2 * PI),
							randf_range(-2 * PI, 2 * PI))
	dice.angular_velocity = Vector3(randf_range(-rotation_speed_max, rotation_speed_max),
									randf_range(-rotation_speed_max, rotation_speed_max),
									randf_range(-rotation_speed_max, rotation_speed_max))
	dice.freeze = false
	_rolling_on_ground = false

func _on_dice_sleeping_state_changed() -> void:
	if dice.sleeping:
		var value := get_top_side_value()
		on_roll_result.emit(value)

func get_top_side_value() -> int:
	var raycasts = dice.get_node("RayCasts").get_children()
	for raycast in raycasts:
		if raycast.is_colliding():
			return raycast.opposite_side
	return -1


func _on_dice_body_entered(_body: Node) -> void:
	if not _rolling_on_ground:
		_rolling_on_ground = true
		on_rolling_on_ground.emit()
