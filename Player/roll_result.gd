class_name RollResult
extends Control

@onready var icon := $TextureRect
@onready var label := $Label
@onready var _fast_dice_roll_sfx := $FastDiceRoll

func _ready() -> void:
	visible = false

func show_roll_result(check_name: String, result: bool):
	label.text = "Check %s: " % check_name
	if result:
		label.text += "success"
		label.add_theme_color_override("font_color", Color.LIGHT_GREEN)
	else:
		label.text += "failed"
		label.add_theme_color_override("font_color", Color.DARK_RED)
		
	_fast_dice_roll_sfx.play()
	$TextureRect/AnimationPlayer.play("roll")
	$Timer.start()
	visible = true


func _on_timer_timeout() -> void:
	visible = false
