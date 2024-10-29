class_name DiceRollWindow
extends Panel

@onready var roll_dice := %RollDice
@onready var header_label := %HeaderLabel
@onready var result_label := %ResultLabel
@onready var roll_button := $RollButton
@onready var confirm_button := $ConfirmButton

@export var difficulty_class: int = 10
@export var skill: Skills.Skill
@export var unit: Unit

var _roll_result: int

signal on_roll_result(bool)

func _ready() -> void:
	header_label.text = "Checking %s, DC: %d" % [Skills.skill_name(skill), difficulty_class]
	result_label.visible = false
	confirm_button.visible = false
	roll_dice.add_dice(RollDice.DiceType.D20)

func roll() -> void:
	roll_dice.roll()
	roll_button.visible = false
	result_label.visible = false
	confirm_button.visible = false

func _on_roll_result(values: Array) -> void:
	_roll_result = values[0]
	result_label.text = "You rolled: %s" % _roll_result
	result_label.visible = true
	
	roll_button.text = "Reroll"
	roll_button.visible = true
	
	confirm_button.visible = true

func _on_confirm_button_pressed() -> void:
	var success = _roll_result >= difficulty_class
	on_roll_result.emit(success)
	_on_close_button_pressed()

func _on_close_button_pressed() -> void:
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	gui.close_window(self)
