class_name DiceRollWindow
extends Panel

var check: Check
var unit: Unit
var _roll_result: Check.RollResult

@onready var roll_dice := %RollDice
@onready var check_label := %CheckLabel
@onready var difficulty_class_label := %DifficultyClassLabel
@onready var result_label := %ResultLabel
@onready var roll_button := %RollButton
@onready var confirm_button := %ConfirmButton

signal on_roll_result(roll_result: Check.RollResult)

func _ready() -> void:
	check_label.text = "Checking %s" % check.title()
	difficulty_class_label.text = "Difficulty class: %d" % check.difficulty_class
	
	result_label.visible = false
	confirm_button.visible = false
	roll_dice.add_dice(Check.DiceType.D20)
	
	for bonus in check.get_bonuses(unit):
		var bonus_cell = preload("res://DiceRoll/bonus_cell.tscn").instantiate()
		%BonusesContainer.add_child(bonus_cell)
		bonus_cell.fill(bonus)

func roll() -> void:
	roll_dice.roll()
	roll_button.visible = false
	result_label.visible = false
	confirm_button.visible = false

func _on_roll_result(values: Array) -> void:
	_roll_result = check.roll(unit, values[0])
	result_label.text = "You rolled: %s\n" % _roll_result.value
	if _roll_result.critical:
		result_label.text += "Critical "
	result_label.text += "Success!" if _roll_result.success else "Failure"
	result_label.visible = true
	
	roll_button.text = "Reroll"
	roll_button.visible = true
	
	confirm_button.visible = true
	
	%RollResultSFX.play()

func _on_confirm_button_pressed() -> void:
	on_roll_result.emit(_roll_result)
	queue_free()

func _on_close_button_pressed() -> void:
	queue_free()
