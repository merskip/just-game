class_name Inventory
extends Node

var items: Array[InventoryItem] = []

signal items_changed

func add_items(new_items: Array[InventoryItem]):
	items.append_array(new_items)
	print("Added items to inventory: ", new_items)
	items_changed.emit()
