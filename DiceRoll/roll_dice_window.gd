class_name DiceRollWindow
extends Panel

@onready var roll_dice := %RollDice
@onready var result_label := %ResultLabel
@onready var roll_button := $RollButton

func _ready() -> void:
	result_label.visible = false
	roll_dice.add_dice(RollDice.DiceType.D20)

func roll() -> void:
	roll_dice.roll()
	roll_button.visible = false
	result_label.visible = false

func _on_roll_result(values: Array) -> void:
	result_label.text = "You rolled: %s" % values[0]
	result_label.visible = true
	
	roll_button.text = "Reroll"
	roll_button.visible = true

func _on_close_button_pressed() -> void:
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	gui.close_window(self)
