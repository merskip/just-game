class_name GameManager
extends Node

@export var player: Unit

func _ready() -> void:
	player.on_die.connect(on_player_die)
	
func on_player_die():
	print("You died! Reseting scene...")
	get_tree().call_deferred("reload_current_scene")
