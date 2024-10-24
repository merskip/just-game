class_name Damage
extends Resource

@export var count: int = 1
@export var dice_type: RollDice.DiceType = RollDice.DiceType.D4
@export var modifier: int = 0

func resolve() -> int:
	var result = 0
	for i in count:
		result += randi_range(1, dice_type)
	result += modifier
	return result

func _to_string() -> String:
	var text = "%dd%d" % [count, dice_type]
	if modifier > 0:
		text += " + %d" % modifier
	return text
