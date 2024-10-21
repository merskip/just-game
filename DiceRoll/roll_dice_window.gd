class_name DiceRollWindow
extends Panel

@onready var roll_dice: RollDice = %RollDice
@onready var result_label: Label = %ResultLabel
@onready var roll_button: Button = $RollButton

@onready var dice_roll_start_sfx: AudioStreamPlayer = $DiceRollStart
@onready var dice_rolling_sfx: AudioStreamPlayer = $DiceRolling


func _ready() -> void:
	result_label.visible = false

func roll() -> void:
	roll_dice.roll()
	roll_button.visible = false
	result_label.visible = false
	dice_roll_start_sfx.play()

func _on_roll_result(value: int) -> void:
	dice_roll_start_sfx.stop()
	dice_rolling_sfx.stop()
	result_label.text = "You rolled: %s" % value
	result_label.visible = true
	
	roll_button.text = "Reroll"
	roll_button.visible = true

func _on_close_button_pressed() -> void:
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	gui.close_window(self)

func _on_rolling_on_ground() -> void:
	dice_rolling_sfx.play()
