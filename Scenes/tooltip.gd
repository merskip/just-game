class_name Tooltip
extends Control

func fill_with_item(item: InventoryItem):
	%IconTexture.texture = item.icon
	%NameLabel.text = item.name
	%DescriptionLabel.text = ""
	%DescriptionLabel.push_italics()
	%DescriptionLabel.add_text(item.description)
