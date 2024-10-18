class_name GUI
extends CanvasLayer

func _on_inventory_button_pressed() -> void:
	show_inventory()


func show_inventory():
	var player_unit: Unit = %Player.get_node("Unit")
	var inventory_window: InventoryWindow = preload("res://Inventory/inventory_window.tscn").instantiate()
	add_child(inventory_window)
	inventory_window.fill(player_unit.inventory)
