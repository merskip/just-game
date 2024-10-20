class_name GUI
extends CanvasLayer

var _window: Control
@onready var _notifications_text_label = $NotificationsTextLabel

func _ready() -> void:
	notifications_manager.on_notification.connect(on_notification)

func _on_inventory_button_pressed() -> void:
	show_inventory()

func show_inventory():
	var player_unit: Unit = %Player.get_node("Unit")
	var inventory_window: InventoryWindow = preload("res://Inventory/inventory_window.tscn").instantiate()
	open_window(inventory_window)
	inventory_window.fill(player_unit.inventory)

func open_window(window: Control):
	close_window()
	print("Open window: %s" % window)
	add_child(window)
	_window = window

func close_window(specific_window: Control = null):
	if _window != null:
		if specific_window != null and _window != specific_window:
			# Opened window is different then requested to close specific window
			return
		print("Close window: %s" % _window)
		_window.queue_free()
		_window = null

func on_notification(text: String):
	_notifications_text_label.add_text(text + "\n")
