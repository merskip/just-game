class_name DisarmTrap
extends Interaction

@export var difficulty_class: int = 10
var enabled: bool = false

signal on_disarmed

func is_interactable(_unit: Unit) -> bool:
	return enabled

func interact(_unit: Unit):
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	var success = await gui.show_dice_roll(Skills.Skill.SLEIGHT_OF_HAND, difficulty_class).on_roll_result
	if success:
		notifications_manager.notify("Disarmed successfully")
		on_disarmed.emit()
