class_name InventoryItemCell
extends Button

@onready var icon_texture: TextureRect = $MarginContainer/ItemIcon
@onready var name_label: Label = $MarginContainer/ItemName

func fill(item: InventoryItem):
	icon_texture.texture = item.icon
	name_label.text = item.name
