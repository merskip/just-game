class_name DiceRollWindow
extends Panel

@onready var roll_dice := %RollDice
@onready var check_label := %CheckLabel
@onready var difficulty_class_label := %DifficultyClassLabel
@onready var result_label := %ResultLabel
@onready var roll_button := %RollButton
@onready var confirm_button := %ConfirmButton

@export var difficulty_class: int = 10
@export var skill: Skills.Skill
@export var unit: Unit

var _roll_result: int
var _success: bool

signal on_roll_result(bool)

func _ready() -> void:
	check_label.text = "Checking %s" % Skills.skill_name(skill)
	difficulty_class_label.text = "Difficulty class: %d" % difficulty_class
	
	result_label.visible = false
	confirm_button.visible = false
	roll_dice.add_dice(Check.DiceType.D20)

func roll() -> void:
	roll_dice.roll()
	roll_button.visible = false
	result_label.visible = false
	confirm_button.visible = false

func _on_roll_result(values: Array) -> void:
	_roll_result = values[0]
	_success = _roll_result >= difficulty_class
	result_label.text = "You rolled: %s" % _roll_result
	if _success:
		result_label.text += "\nSuccess!"
	else:
		result_label.text += "\nFailure"
	result_label.visible = true
	
	roll_button.text = "Reroll"
	roll_button.visible = true
	
	confirm_button.visible = true
	
	%RollResultSFX.play()

func _on_confirm_button_pressed() -> void:
	on_roll_result.emit(_success)
	queue_free()

func _on_close_button_pressed() -> void:
	queue_free()
