class_name CharacterWindow
extends Panel

@export var unit: Unit

@onready var strength := %Strength
@onready var dexterity := %Dexterity
@onready var constitution := %Constitution
@onready var intelligence := %Intelligence
@onready var wisdom := %Wisdom
@onready var charisma := %Charisma

func _ready() -> void:
	strength.fill("Strength", unit.abilities.strength)
	dexterity.fill("Dexterity", unit.abilities.dexternity)
	constitution.fill("Constitution", unit.abilities.constitution)
	intelligence.fill("Intelligence", unit.abilities.intelligence)
	wisdom.fill("Wisdom", unit.abilities.wisdom)
	charisma.fill("Charisma", unit.abilities.charisma)

func _on_close_button_pressed() -> void:
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	gui.close_window(self)
