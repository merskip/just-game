class_name Skills
extends Resource

@export var proficiencies: Array[Skill]

enum Skill {
	ACROBATICS,
	ANIMAL_HANDLING,
	ARCANA,
	ATHLETICS,
	DECEPTION,
	HISTORY,
	INSIGHT,
	INTIMIDATION,
	INVESTIGATION,
	MEDICINE,
	NATURE,
	PERCEPTION,
	PERFORMANCE,
	PERSUASION,
	RELIGION,
	SLEIGHT_OF_HAND,
	STEALTH,
	SURVIVAL
}

func get_skill_modifier(skill: Skill, abilities: Abilities, proficiency_bonus: int) -> int:
	var ability = get_ability_for_skill(skill)
	var ability_modifier = abilities.get_ability_modifier(ability)
	
	if has_proficiency(skill):
		return ability_modifier + proficiency_bonus
	else:
		return ability_modifier


func has_proficiency(skill: Skill) -> bool:
	return skill in proficiencies

static func get_ability_for_skill(skill: Skill) -> Abilities.Ability:
	match skill:
		Skill.ACROBATICS, Skill.SLEIGHT_OF_HAND, Skill.STEALTH:
			return Abilities.Ability.DEXTERITY
		Skill.ANIMAL_HANDLING, Skill.INSIGHT, Skill.MEDICINE, Skill.PERCEPTION, Skill.SURVIVAL:
			return Abilities.Ability.WISDOM
		Skill.ARCANA, Skill.HISTORY, Skill.INVESTIGATION, Skill.NATURE, Skill.RELIGION:
			return Abilities.Ability.INTELLIGENCE
		Skill.ATHLETICS:
			return Abilities.Ability.STRENGTH
		Skill.DECEPTION, Skill.INTIMIDATION, Skill.PERFORMANCE, Skill.PERSUASION:
			return Abilities.Ability.CHARISMA
	return Abilities.Ability.STRENGTH

static func skill_name(skill: Skill) -> String:
	match skill:
		Skill.ACROBATICS:
			return "Acrobatics"
		Skill.ANIMAL_HANDLING:
			return "Animal Handling"
		Skill.ARCANA:
			return "Arcana"
		Skill.ATHLETICS:
			return "Athletics"
		Skill.DECEPTION:
			return "Deception"
		Skill.HISTORY:
			return "History"
		Skill.INSIGHT:
			return "Insight"
		Skill.INTIMIDATION:
			return "Intimidation"
		Skill.INVESTIGATION:
			return "Investigation"
		Skill.MEDICINE:
			return "Medicine"
		Skill.NATURE:
			return "Nature"
		Skill.PERCEPTION:
			return "Perception"
		Skill.PERFORMANCE:
			return "Performance"
		Skill.PERSUASION:
			return "Persuasion"
		Skill.RELIGION:
			return "Religion"
		Skill.SLEIGHT_OF_HAND:
			return "Sleight of Hand"
		Skill.STEALTH:
			return "Stealth"
		Skill.SURVIVAL:
			return "Survival"
	return ""
