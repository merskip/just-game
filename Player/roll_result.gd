class_name RollResult
extends Control

@export var success_color := Color.GREEN
@export var failure_color := Color.RED

@onready var icon := $TextureRect
@onready var label := $Label
@onready var result_label := $TextureRect/ResultLabel
@onready var _fast_dice_roll_sfx := $FastDiceRoll

func _ready() -> void:
	visible = false

func show_roll_result(skill: Skills.Skill, roll_result: int, sucess: bool):
	label.text = Skills.skill_name(skill)
	result_label.text = str(roll_result)
	if sucess:
		result_label.add_theme_color_override("font_color", success_color)
		set_dice_outline(success_color)
	else:
		result_label.add_theme_color_override("font_color", failure_color)
		set_dice_outline(failure_color)
		
	_fast_dice_roll_sfx.play()
	$AnimationPlayer.play("roll")
	$Timer.start()
	visible = true

func set_dice_outline(color: Color):
	var anim: Animation = $AnimationPlayer.get_animation("roll")
	var track_id := anim.find_track(".:material:shader_parameter/outline_color", Animation.TYPE_VALUE)
	var key_id := anim.track_find_key(track_id, 1.0)
	anim.track_set_key_value(track_id, key_id, color)

func _on_timer_timeout() -> void:
	visible = false
