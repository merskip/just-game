class_name InventoryItem
extends Resource

@export var name: String
@export var description: String
@export var icon: Texture2D

func _to_string() -> String:
	return "InventoryItem(name=\"%s\")" % name
