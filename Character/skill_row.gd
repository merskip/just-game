class_name SkillRow
extends HBoxContainer

@onready var icon_texture := $Icon
@onready var title_label := $Title
@onready var ability_label := $Ability
@onready var proficiency_label := $Proficiency
@onready var modifier_label := $Modifier

func fill(icon: Texture2D, title: String, ability: String, has_profinency: bool, modifier: int):
	icon_texture.texture = icon
	title_label.text = title
	ability_label.text = ability
	proficiency_label.text = "🌟" if has_profinency else ""
	modifier_label.text = "%+d" % modifier
