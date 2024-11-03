class_name InteractAction
extends Action

var interaction: Interaction

func _init(_interaction: Interaction) -> void:
	self.interaction = _interaction
	icon = load("res://3rd party/tw-dnd/util/cog.svg")

func start(unit: Unit):
	if interaction.is_interactable(unit):
		interaction.interact(unit)
	await unit.get_tree().physics_frame # temp workaround
	finished.emit()
