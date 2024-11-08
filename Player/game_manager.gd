class_name GameManager
extends Node

var player: Unit
var gui: GUI

func _ready() -> void:
	setup()

func on_player_die():
	print("You died! Reseting scene...")
	await get_tree().physics_frame
	get_tree().reload_current_scene()
	await get_tree().tree_changed
	setup()

func setup():
	var scene = get_tree().current_scene
	player = scene.get_node_or_null("%Player")
	gui = scene.get_node_or_null("%GUI")
	
	if player != null:
		player.on_die.connect(on_player_die)
		player.on_actions_queue_change.connect(gui.on_player_actions_queue_change.bind(player))
