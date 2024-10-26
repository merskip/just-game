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

func show_roll_result(check_name: String, roll_result: int, sucess: bool):
	label.text = "Check %s" % check_name
	result_label.text = "%s" % roll_result
	if sucess:
		result_label.add_theme_color_override("font_color", success_color)
	else:
		result_label.add_theme_color_override("font_color", failure_color)
		
		
	_fast_dice_roll_sfx.play()
	$AnimationPlayer.play("roll")
	$Timer.start()
	visible = true

func _on_timer_timeout() -> void:
	visible = false
