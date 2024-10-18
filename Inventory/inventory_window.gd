class_name InventoryWindow
extends Panel

@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/GridContainer
var _item_cell = preload("res://Inventory/inventory_item_cell.tscn")

func fill(inventory: Inventory):
	for item in inventory.items:
		var cell: InventoryItemCell = _item_cell.instantiate()
		grid_container.add_child(cell)
		cell.fill(item)

func _on_close_button_pressed() -> void:
	queue_free()
