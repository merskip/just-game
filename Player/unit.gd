class_name Unit
extends CharacterBody2D

@export var movement: Movement
@export var abilities: Abilities
@export var skills: Skills
@export var max_health: int = 100

@onready var _grunt_sfx := $Grunt

var inventory: Inventory = Inventory.new()
var _health: int

signal on_health_change()
signal on_die()

var _floating_damage_label := preload("res://Player/floating_damage_label.tscn")
var _dice_icon := preload("res://DiceRoll/dice_icon.svg")

func _ready() -> void:
	_health = max_health
	on_health_change.emit()

func check_skill_on_fly(skill: Skills.Skill, difficulty_class: int) -> bool:
	var roll_result = randi_range(1, 20)
	roll_result += skills.get_skill_modifier(skill, abilities, 3)
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

func take_damage(damage: Damage):
	var damage_value = damage.resolve()
	_health = max(0, _health - damage_value)
	_grunt_sfx.play()
	_show_floating_damage_label(damage_value)
	notifications_manager.notify("Unit \"%s\" received %d damage (%s)" % [name, damage_value, damage])
	on_health_change.emit()
	if _health <= 0:
		on_die.emit()

func _show_floating_damage_label(damage_value: int):
	var floating_damage_label := _floating_damage_label.instantiate()
	floating_damage_label.text = "%s" % damage_value
	add_child(floating_damage_label)
	floating_damage_label.position = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if movement != null:
		movement.physics_process(self, delta)
