extends Panel

@onready var roll_dice: RollDice = %RollDice
@onready var result_label: Label = %ResultLabel
@onready var roll_button: Button = $RollButton

func _ready() -> void:
	result_label.visible = false

func roll() -> void:
	roll_dice.roll()
	roll_button.visible = false

func _on_roll_dice(value: int) -> void:
	result_label.text = "You rolled: %s" % value
	result_label.visible = true
