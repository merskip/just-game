class_name AbilityRow
extends HBoxContainer

@onready var icon_texture := $Icon
@onready var title_label := $Title
@onready var value_label := $Value
@onready var modifier_label := $Modifier

func fill(icon: Texture2D, title: String, value: int):
	icon_texture.texture = icon
	title_label.text = title
	value_label.text = str(value)
	modifier_label.text = "%+d" % Abilities.modifier(value)
