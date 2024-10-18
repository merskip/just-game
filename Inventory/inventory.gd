class_name Inventory
extends Node

var items: Array[InventoryItem] = []

signal items_changed

func add_item(item: InventoryItem):
	items.append(item)
	items_changed.emit()
	
