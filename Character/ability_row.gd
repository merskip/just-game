extends HBoxContainer

@onready var title_label := $Title
@onready var value_label := $Value
@onready var modifier_label := $Modifier

func fill(title: String, value: int):
	title_label.text = title
	value_label.text = str(value)
	modifier_label.text = "%+d" % Abilities.modifier(value)
