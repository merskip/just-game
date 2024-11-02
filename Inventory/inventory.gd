class_name Inventory
extends Node

var items: Array[InventoryItem] = []

signal items_changed

func has_item(item: InventoryItem) -> bool:
	return items.has(item)

func add_items(new_items: Array[InventoryItem]):
	if new_items.is_empty():
		return
	
	items.append_array(new_items)
	var new_items_names = new_items.map(func(item): return item.name)
	var icon = null
	if new_items.size() == 1:
		icon = new_items[0].icon
	notifications_manager.notify("Added items to inventory: %s" % str(new_items_names), icon)
	items_changed.emit()

func remove_item(item: InventoryItem):
	if not items.has(item):
		return
	items.erase(item)
	notifications_manager.notify("Item %s removed from inventory" % item.name, item.icon)
	items_changed.emit()
