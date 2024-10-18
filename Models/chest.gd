class_name Chest
extends Interaction

@export var items: Array[InventoryItem]

func interact(unit: Unit):
	print("The chest was opened")
	unit.inventory.add_items(items)
	items.clear()
