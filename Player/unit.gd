class_name Unit
extends CharacterBody2D

@export var movement: Movement
var inventory: Inventory = Inventory.new()
var _health: int
var _max_health: int = 100

signal on_health_change()
signal on_die()

var _floating_damage_label = preload("res://Player/floating_damage_label.tscn")

func _ready() -> void:
	_health = _max_health
	on_health_change.emit()

func take_damage(damage: int):
	_health = max(0, _health - damage)
	var floating_damage_label := _floating_damage_label.instantiate()
	floating_damage_label.text = "%s" % damage
	add_child(floating_damage_label)
	floating_damage_label.position = Vector2.ZERO
	on_health_change.emit()
	if _health <= 0:
		on_die.emit()

func _physics_process(delta: float) -> void:
	if movement != null:
		movement.physics_process(self, delta)
