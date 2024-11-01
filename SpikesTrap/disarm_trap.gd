class_name DisarmTrap
extends Interaction

@export var difficulty_class: int = 10
var enabled: bool = false

signal on_disarmed

func is_interactable(_unit: Unit) -> bool:
	return enabled

func interact(unit: Unit):
	var check = Check.of_skill(difficulty_class, Skills.Skill.SLEIGHT_OF_HAND)
	if await unit.check_interactive(check):
		notifications_manager.notify("Disarmed successfully")
		on_disarmed.emit()
