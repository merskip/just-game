class_name GameManager
extends Node

@onready var player: Unit = $"../Player/Unit"

func _ready() -> void:
	player.on_die.connect(on_player_die)
	
func on_player_die():
	print("You died! Reseting scene...")
	get_tree().reload_current_scene()
