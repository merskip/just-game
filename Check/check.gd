class_name Check

var difficulty_class: int

const CRITICAL_FAILURE := 1
const CRITICAL_SUCCESS := 20

class AbilityCheck:
	extends Check
	var ability: Abilities.Ability
	
	func get_bonuses(unit: Unit) -> Array[Bonus]:
		var bonuses = super.get_bonuses(unit)
		bonuses.append(ability_bonus(unit))
		return bonuses
	
	func ability_bonus(unit: Unit) -> Bonus:
		var bonus = Bonus.new()
		bonus.name = Abilities.ability_name(ability)
		bonus.icon = Abilities.ability_icon(ability)
		bonus.modifier = unit.abilities.get_ability_modifier(ability)
		return bonus
		
	func title() -> String:
		return Abilities.ability_name(ability)

class SkillCheck:
	extends AbilityCheck
	var skill: Skills.Skill
	
	func get_bonuses(unit: Unit) -> Array[Bonus]:
		var bonuses = super.get_bonuses(unit)
		bonuses.append(skill_bonus(unit))
		return bonuses
	
	func skill_bonus(unit: Unit) -> Bonus:
		var bonus = Bonus.new()
		bonus.name = Skills.skill_name(skill)
		bonus.icon = Skills.skill_icon(skill)
		bonus.modifier = unit.skills.get_skill_modifier(skill, unit.get_proficiency_bonus())
		return bonus
		
	func title() -> String:
		return Skills.skill_name(skill)

class Bonus:
	var name: String
	var icon: Texture2D
	var modifier: int
	
	func _to_string() -> String:
		return "%s %+d" % [name, modifier]

static func of_skill(_difficulty_class: int, _skill: Skills.Skill) -> Check:
	var check = SkillCheck.new()
	check.difficulty_class = _difficulty_class
	check.skill = _skill
	check.ability = Skills.get_ability_for_skill(_skill)
	return check

func roll(unit: Unit, value: int = 0) -> RollResult:
	value = randi_range(1, DiceType.D20) if value == 0 else value
	if value == CRITICAL_FAILURE:
		return RollResult.new(value, false)
	elif value == CRITICAL_SUCCESS:
		return RollResult.new(value, true)
	else:
		value += get_total_bonuses_modifiers(unit)
		var success = value >= difficulty_class
		return RollResult.new(value, success)

func get_total_bonuses_modifiers(unit: Unit) -> int:
	var total = 0
	for bonus in get_bonuses(unit):
		total += bonus.modifier
	return total

func get_bonuses(_unit: Unit) -> Array[Bonus]:
	return []

func title() -> String:
	return ""

enum DiceType {
	D4 = 4,
	D6 = 6,
	D8 = 8,
	D10 = 10,
	D12 = 12,
	D20 = 20,
	D100 = 100
}

static func dice_name(dice_type: DiceType) -> String:
	return "D%s" % dice_type
	
class RollResult:
	var value: int
	var success: bool
	
	func _init(_value: int, _success: bool):
		self.value = _value
		self.success = _success
