class_name GameManager
extends Node

@onready var player := %Player
@onready var gui := %GUI 

func _ready() -> void:
	player.on_die.connect(on_player_die)
	player.on_actions_queue_change.connect(gui.on_player_actions_queue_change.bind(player))
	
func on_player_die():
	print("You died! Reseting scene...")
	get_tree().call_deferred("reload_current_scene")
