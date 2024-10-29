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
		Ability.STRENGTH: return "Strength"
		Ability.DEXTERITY: return "Dexterity"
		Ability.CONSTITUTION: return "Constitution"
		Ability.INTELLIGENCE: return "Intelligence"
		Ability.WISDOM: return "Wisdom"
		Ability.CHARISMA: return "Charisma"
	return ""

static func ability_icon(ability: Ability) -> Texture2D:
	match ability:
		Ability.STRENGTH: return load("res://3rd party/tw-dnd/ability/strength.svg")
		Ability.DEXTERITY: return load("res://3rd party/tw-dnd/ability/dexterity.svg")
		Ability.CONSTITUTION: return load("res://3rd party/tw-dnd/ability/constitution.svg")
		Ability.INTELLIGENCE: return load("res://3rd party/tw-dnd/ability/intelligence.svg")
		Ability.WISDOM: return load("res://3rd party/tw-dnd/ability/wisdom.svg")
		Ability.CHARISMA: return load("res://3rd party/tw-dnd/ability/charisma.svg")
	return null
