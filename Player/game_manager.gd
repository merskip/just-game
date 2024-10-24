class_name GameManager
extends Node

@onready var player: Player = %Player

func _ready() -> void:
	player.get_node("Unit").on_die.connect(on_player_die)
	
func on_player_die():
	print("You died! Reseting scene...")
	get_tree().reload_current_scene()
