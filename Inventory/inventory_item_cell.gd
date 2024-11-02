class_name InventoryItemCell
extends Button

@onready var icon_texture := %ItemIcon
@onready var name_label := %ItemName

var _item: InventoryItem
var _tooltip := preload("res://Scenes/tooltip.tscn")

func fill(item: InventoryItem):
	_item = item
	icon_texture.texture = item.icon
	name_label.text = item.name
	tooltip_text = item.name

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltip: Tooltip = _tooltip.instantiate()
	tooltip.fill_with_item(_item)
	return tooltip
