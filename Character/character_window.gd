class_name CharacterWindow
extends Panel

@export var unit: Unit

@onready var strength := %Strength
@onready var dexterity := %Dexterity
@onready var constitution := %Constitution
@onready var intelligence := %Intelligence
@onready var wisdom := %Wisdom
@onready var charisma := %Charisma

@onready var cointainer := $VBoxContainer/ScrollContainer/VBoxContainer
@onready var skill_header := %"Skill Header"

var skill_row_scene := preload("res://Character/skill_row.tscn")

func _ready() -> void:
	fill_abilities()
	fill_skills()

func fill_abilities():
	strength.fill("Strength", unit.abilities.strength)
	dexterity.fill("Dexterity", unit.abilities.dexterity)
	constitution.fill("Constitution", unit.abilities.constitution)
	intelligence.fill("Intelligence", unit.abilities.intelligence)
	wisdom.fill("Wisdom", unit.abilities.wisdom)
	charisma.fill("Charisma", unit.abilities.charisma)

func fill_skills():
	for skill in Skills.Skill.values():
		add_skill(skill)

func add_skill(skill: Skills.Skill):
	var skill_row: SkillRow = skill_row_scene.instantiate()
	cointainer.add_child(skill_row)
	var skill_name = Skills.skill_name(skill)
	var ability = Skills.get_ability_for_skill(skill)
	var ability_name = Abilities.ability_name(ability)
	var has_proficiency = unit.skills.has_proficiency(skill)
	var modifier = unit.skills.get_skill_modifier(skill, unit.abilities, 3)
	skill_row.fill(skill_name, ability_name, has_proficiency, modifier)

func _on_close_button_pressed() -> void:
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	gui.close_window(self)
