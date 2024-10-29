class_name Unit
extends CharacterBody2D

@export var character_name: String
@export var race: Race = Race.HUMAN
@export var class_type: ClassType = ClassType.FIGHTER
@export var level: int = 1
@export var abilities: Abilities
@export var skills: Skills

@export var movement: Movement

@onready var _grunt_sfx := $Grunt

var inventory: Inventory = Inventory.new()
var _current_hit_point: int
var _max_hit_points: int

signal on_health_change()
signal on_die()

var _floating_damage_label := preload("res://Player/floating_damage_label.tscn")
var _dice_icon := preload("res://DiceRoll/dice_icon.svg")

func _ready() -> void:
	_max_hit_points = calculate_max_hit_points()
	_current_hit_point = _max_hit_points
	on_health_change.emit()

func check_skill_on_fly(skill: Skills.Skill, difficulty_class: int) -> bool:
	var roll_result = randi_range(1, 20)
	var proficiency_bonus = get_proficiency_bonus()
	roll_result += skills.get_skill_modifier(skill, abilities, proficiency_bonus)
	var success = roll_result >= difficulty_class
	notifications_manager.notify(
		"Check %s: %d (%s), DC: %d" % [
			Skills.skill_name(skill),
			roll_result,
			"success" if success else "failure",
			difficulty_class],
		_dice_icon)
	$RollResult.show_roll_result(skill, roll_result, success)
	await get_tree().create_timer(0.8).timeout
	return success

func get_proficiency_bonus() -> int:
	return 2 + int(float(level - 1) / 4)
	
func take_damage(damage: Damage):
	var damage_value = damage.resolve()
	_current_hit_point = max(0, _current_hit_point - damage_value)
	_grunt_sfx.play()
	_show_floating_damage_label(damage_value)
	notifications_manager.notify("Unit \"%s\" received %d damage (%s)" % [name, damage_value, damage])
	on_health_change.emit()
	if _current_hit_point <= 0:
		on_die.emit()

func _show_floating_damage_label(damage_value: int):
	var floating_damage_label := _floating_damage_label.instantiate()
	floating_damage_label.text = "%s" % damage_value
	add_child(floating_damage_label)
	floating_damage_label.position = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if movement != null:
		movement.physics_process(self, delta)

func calculate_max_hit_points() -> int:
	var hit_dice = get_hit_dice(class_type)
	var constitution_modifier = abilities.get_ability_modifier(Abilities.Ability.CONSTITUTION)
	if level <= 1:
		return hit_dice + constitution_modifier
	var total_hp = hit_dice + constitution_modifier
	total_hp += (int(float(hit_dice) / 2) + 1 + constitution_modifier) * (level - 1)
	return total_hp

static func get_hit_dice(_class_type: ClassType) -> RollDice.DiceType:
	match _class_type:
		ClassType.BARBARIAN:
			return RollDice.DiceType.D12
		ClassType.BARD, ClassType.CLERIC, ClassType.DRUID, ClassType.MONK, ClassType.ROGUE, ClassType.WARLOCK:
			return RollDice.DiceType.D8
		ClassType.FIGHTER, ClassType.PALADIN, ClassType.RANGER:
			return RollDice.DiceType.D10
		ClassType.SORCERER, ClassType.WIZARD:
			return RollDice.DiceType.D6
	return RollDice.DiceType.D8

enum Race {
	DRAGONBORN,
	DWARF,
	ELF,
	GNOME,
	HALF_ELF,
	HALF_ORC,
	HALFLING,
	HUMAN,
	TIEFLING
}

enum ClassType {
	BARBARIAN,
	BARD,
	CLERIC,
	DRUID,
	FIGHTER,
	MONK,
	PALADIN,
	RANGER,
	ROGUE,
	SORCERER,
	WARLOCK,
	WIZARD
}

static func race_name(_race: Race) -> String:
	match _race:
		Race.DRAGONBORN:
			return "Dragonborn"
		Race.DWARF:
			return "Dwarf"
		Race.ELF:
			return "Elf"
		Race.GNOME:
			return "Gnome"
		Race.HALF_ELF:
			return "Half-Elf"
		Race.HALF_ORC:
			return "Half-Orc"
		Race.HALFLING:
			return "Halfling"
		Race.HUMAN:
			return "Human"
		Race.TIEFLING:
			return "Tiefling"
	return ""

static func class_type_name(_class_type: ClassType) -> String:
	match _class_type:
		ClassType.BARBARIAN:
			return "Barbarian"
		ClassType.BARD:
			return "Bard"
		ClassType.CLERIC:
			return "Cleric"
		ClassType.DRUID:
			return "Druid"
		ClassType.FIGHTER:
			return "Fighter"
		ClassType.MONK:
			return "Monk"
		ClassType.PALADIN:
			return "Paladin"
		ClassType.RANGER:
			return "Ranger"
		ClassType.ROGUE:
			return "Rogue"
		ClassType.SORCERER:
			return "Sorcerer"
		ClassType.WARLOCK:
			return "Warlock"
		ClassType.WIZARD:
			return "Wizard"
	return ""
