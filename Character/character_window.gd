class_name CharacterWindow
extends Panel

@export var unit: Unit

var ability_row_scene := preload("res://Character/ability_row.tscn")
var skill_row_scene := preload("res://Character/skill_row.tscn")

func _ready() -> void:
	fill_general_information()
	fill_abilities()
	fill_skills()
	unit.on_hit_points_change.connect(fill_general_information)

func fill_general_information():
	%CharacterName.text = "Character name: %s" % unit.character_name
	%AvatarIcon.texture = unit.avatar
	%Race.text = "Race: %s" % Unit.race_name(unit.race)
	%ClassType.text = "Class: %s" % Unit.class_type_name(unit.class_type)
	%Level.text = "Level: %d" % unit.level
	%HitPoints.text = "Hit Points: %d/%d" % [unit._current_hit_point, unit._max_hit_points]
	%ClassIcon.texture = Unit.class_icon(unit.class_type)

func fill_abilities():
	for ability in Abilities.Ability.values():
		add_ability(ability)

func add_ability(ability: Abilities.Ability):
	var ability_row: AbilityRow = ability_row_scene.instantiate()
	%AbilitiesContainer.add_child(ability_row)
	var ability_icon = Abilities.ability_icon(ability)
	var ability_name = Abilities.ability_name(ability)
	ability_row.fill(ability_icon, ability_name, unit.abilities.get_ability_value(ability))

func fill_skills():
	%ProficiencyBonus.text = "Proficency bonus: %+d" % unit.get_proficiency_bonus()
	for skill in Skills.Skill.values():
		add_skill(skill)

func add_skill(skill: Skills.Skill):
	var skill_row: SkillRow = skill_row_scene.instantiate()
	%SkillsContainer.add_child(skill_row)
	var skill_icon = Skills.skill_icon(skill)
	var skill_name = Skills.skill_name(skill)
	var ability = Skills.get_ability_for_skill(skill)
	var ability_name = Abilities.ability_name(ability)
	var has_proficiency = unit.skills.has_proficiency(skill)
	var proficiency_bonus = unit.get_proficiency_bonus()
	var modifier = unit.skills.get_skill_and_ability_modifier(skill, unit.abilities, proficiency_bonus)
	skill_row.fill(skill_icon, skill_name, ability_name, has_proficiency, modifier)

func _on_close_button_pressed() -> void:
	queue_free()
