class_name DisarmTrap
extends Interaction

@export var difficulty_class: int = 10
@export var thieves_tools_item: InventoryItem

@onready var spikes_trap := $".."

signal on_disarmed(unit: Unit, success: bool)

func is_interactable(_unit: Unit) -> bool:
	return spikes_trap._detected

func interact(unit: Unit):
	if not unit.inventory.has_item(thieves_tools_item):
		notifications_manager.notify("Missing %s item" % thieves_tools_item.name)
		return
	
	var check = Check.of_skill(difficulty_class, Skills.Skill.SLEIGHT_OF_HAND)
	if await unit.check_interactive(check):
		notifications_manager.notify("Disarmed successfully")
		on_disarmed.emit(unit, true)
	else:
		unit.inventory.remove_item(thieves_tools_item)
		on_disarmed.emit(unit, false)
