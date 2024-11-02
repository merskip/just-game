class_name Unit
extends CharacterBody2D

@export var character_name: String
@export var avatar: Texture2D
@export var race: Race = Race.HUMAN
@export var class_type: ClassType = ClassType.FIGHTER
@export var level: int = 1
@export var abilities: Abilities
@export var skills: Skills

@export var movement: Movement

@onready var _grunt_sfx := $Grunt
@onready var _roll_result_popup := %RollResultPopup

var inventory: Inventory = Inventory.new()
var _current_hit_point: int
var _max_hit_points: int

signal on_hit_points_change()
signal on_die()

var _floating_damage_label := preload("res://Player/floating_damage_label.tscn")
var _dice_icon := preload("res://DiceRoll/dice_icon.svg")

func _ready() -> void:
	_max_hit_points = calculate_max_hit_points()
	_current_hit_point = _max_hit_points
	on_hit_points_change.emit()

func check_on_fly(check: Check) -> bool:
	var roll_result := check.roll(self)
	var bonuses := check.get_bonuses(self)
	notifications_manager.notify(
		"Check %s: %d (%s%s), DC: %d, bonuses: %s" % [
			Skills.skill_name(check.skill),
			roll_result.value,
			"critical " if roll_result.critical else "",
			"success" if roll_result.success else "failure",
			check.difficulty_class,
			bonuses],
		_dice_icon)
	_roll_result_popup.show_roll_result(check.skill, roll_result.value, roll_result.success)
	
	await get_tree().create_timer(0.8).timeout
	return roll_result.success

func check_interactive(check: Check) -> bool:
	var gui = get_tree().current_scene.get_node("%GUI") as GUI
	var roll_result = await gui.show_dice_roll(check, self).on_roll_result
	var bonuses := check.get_bonuses(self)
	notifications_manager.notify(
		"Check %s: %d (%s), DC: %d, bonuses: %s" % [
			Skills.skill_name(check.skill),
			roll_result.value,
			"success" if roll_result.success else "failure",
			check.difficulty_class,
			bonuses],
		_dice_icon)
	return roll_result.success

func get_proficiency_bonus() -> int:
	return 2 + int(float(level - 1) / 4)
	
func take_damage(damage: Damage):
	var damage_value = damage.resolve()
	_current_hit_point = max(0, _current_hit_point - damage_value)
	_grunt_sfx.play()
	_show_floating_damage_label(damage_value)
	notifications_manager.notify("Unit \"%s\" received %d damage (%s)" % [name, damage_value, damage])
	on_hit_points_change.emit()
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

static func get_hit_dice(_class_type: ClassType) -> Check.DiceType:
	match _class_type:
		ClassType.BARBARIAN:
			return Check.DiceType.D12
		ClassType.BARD, ClassType.CLERIC, ClassType.DRUID, ClassType.MONK, ClassType.ROGUE, ClassType.WARLOCK:
			return Check.DiceType.D8
		ClassType.FIGHTER, ClassType.PALADIN, ClassType.RANGER:
			return Check.DiceType.D10
		ClassType.SORCERER, ClassType.WIZARD:
			return Check.DiceType.D6
	return Check.DiceType.D8

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
		Race.DRAGONBORN: return "Dragonborn"
		Race.DWARF: return "Dwarf"
		Race.ELF: return "Elf"
		Race.GNOME: return "Gnome"
		Race.HALF_ELF: return "Half-Elf"
		Race.HALF_ORC: return "Half-Orc"
		Race.HALFLING: return "Halfling"
		Race.HUMAN: return "Human"
		Race.TIEFLING: return "Tiefling"
	return ""

static func class_type_name(_class_type: ClassType) -> String:
	match _class_type:
		ClassType.BARBARIAN: return "Barbarian"
		ClassType.BARD: return "Bard"
		ClassType.CLERIC: return "Cleric"
		ClassType.DRUID: return "Druid"
		ClassType.FIGHTER: return "Fighter"
		ClassType.MONK: return "Monk"
		ClassType.PALADIN: return "Paladin"
		ClassType.RANGER: return "Ranger"
		ClassType.ROGUE: return "Rogue"
		ClassType.SORCERER: return "Sorcerer"
		ClassType.WARLOCK: return "Warlock"
		ClassType.WIZARD: return "Wizard"
	return ""

static func class_icon(_class_type: ClassType) -> Texture2D:
	match _class_type:
		ClassType.BARBARIAN: return load("res://3rd party/tw-dnd/class/barbarian.svg")
		ClassType.BARD: return load("res://3rd party/tw-dnd/class/bard.svg")
		ClassType.CLERIC: return load("res://3rd party/tw-dnd/class/cleric.svg")
		ClassType.DRUID: return load("res://3rd party/tw-dnd/class/druid.svg")
		ClassType.FIGHTER: return load("res://3rd party/tw-dnd/class/fighter.svg")
		ClassType.MONK: return load("res://3rd party/tw-dnd/class/monk.svg")
		ClassType.PALADIN: return load("res://3rd party/tw-dnd/class/paladin.svg")
		ClassType.RANGER: return load("res://3rd party/tw-dnd/class/ranger.svg")
		ClassType.ROGUE: return load("res://3rd party/tw-dnd/class/rogue.svg")
		ClassType.SORCERER: return load("res://3rd party/tw-dnd/class/sorcerer.svg")
		ClassType.WARLOCK: return load("res://3rd party/tw-dnd/class/warlock.svg")
		ClassType.WIZARD: return load("res://3rd party/tw-dnd/class/wizard.svg")
	return null
