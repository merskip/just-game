class_name Inventory
extends Node

var items: Array[InventoryItem] = []

signal items_changed

func add_items(new_items: Array[InventoryItem]):
	if new_items.is_empty():
		return
		
	items.append_array(new_items)
	print("Added items to inventory: %s" % new_items)
	var new_items_names = new_items.map(func(item): return item.name)
	var icon = null
	if new_items.size() == 1:
		icon = new_items[0].icon
	notifications_manager.notify("Added items to inventory: %s" % new_items_names, icon)
	items_changed.emit()
