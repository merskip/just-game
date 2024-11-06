class_name InteractAction
extends Action

var interaction: Interaction

func _init(_interaction: Interaction) -> void:
	self.interaction = _interaction
	icon = load("res://3rd party/tw-dnd/util/cog.svg")

func start():
	if interaction.can_interact(unit):
		await interaction.interact(unit)
	else:
		push_warning(unit, " cannot interact with ", self)
	await unit.get_tree().physics_frame # temp workaround
	finished.emit()

func _to_string() -> String:
	return "InteractAction(interaction=%s)" % interaction
