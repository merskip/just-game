class_name Unit
extends Node

var _health: int
var _max_health: int = 100

signal on_health_change()
signal on_die()

func _ready() -> void:
	_health = _max_health

func take_damage(damage: int):
	_health = max(0, _health - damage)
	on_health_change.emit()
	if _health <= 0:
		on_die.emit()
