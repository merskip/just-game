class_name SkillRow
extends HBoxContainer

@onready var title_label := $Title
@onready var ability_label := $Ability
@onready var proficiency_label := $Proficiency
@onready var modifier_label := $Modifier

func fill(skill: String, ability: String, has_profinency: bool, modifier: int):
	title_label.text = skill
	ability_label.text = ability
	proficiency_label.text = "🌟" if has_profinency else ""
	modifier_label.text = "%+d" % modifier
