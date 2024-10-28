class_name Abilities
extends Resource

@export var strength: int
@export var dexterity: int
@export var constitution: int
@export var intelligence: int
@export var wisdom: int
@export var charisma: int

enum Ability {
	STRENGTH,
	DEXTERITY,
	CONSTITUTION,
	INTELLIGENCE,
	WISDOM,
	CHARISMA
}

func get_ability_value(ability: Ability) -> int:
	match ability:
		Ability.STRENGTH:
			return strength
		Ability.DEXTERITY:
			return dexterity
		Ability.CONSTITUTION:
			return constitution
		Ability.INTELLIGENCE:
			return intelligence
		Ability.WISDOM:
			return wisdom
		Ability.CHARISMA:
			return charisma
	return 0

func get_ability_modifier(ability: Ability) -> int:
	return modifier(get_ability_value(ability))

static func modifier(ability_value: int) -> int:
	return int(floor((float(ability_value) - 10) / 2))

static func ability_name(ability: Ability) -> String:
	match ability:
		Ability.STRENGTH:
			return "Strength"
		Ability.DEXTERITY:
			return "Dexterity"
		Ability.CONSTITUTION:
			return "Constitution"
		Ability.INTELLIGENCE:
			return "Intelligence"
		Ability.WISDOM:
			return "Wisdom"
		Ability.CHARISMA:
			return "Charisma"
	return ""
