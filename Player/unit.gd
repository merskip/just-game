class_name Unit
extends CharacterBody2D

@export var movement: Movement
@export var abilities: Abilities
@export var max_health: int = 100

@onready var _grunt_sfx := $Grunt

var inventory: Inventory = Inventory.new()
var _health: int

signal on_health_change()
signal on_die()

var _floating_damage_label := preload("res://Player/floating_damage_label.tscn")

func _ready() -> void:
	_health = max_health
	on_health_change.emit()
	
func check_wisdom() -> bool:
	var result = randi_range(1, 20) <= abilities.wisdom
	notifications_manager.notify("Check wisdom: %s" % result)
	$RollResult.show_roll_result("wisdom", result)
	return result

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
