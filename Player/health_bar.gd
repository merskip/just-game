extends ProgressBar

@onready var unit: Unit = $".."

func _on_hit_points_change() -> void:
	_update_progress()

func _update_progress():
	value = unit._current_hit_point
	max_value = unit._max_hit_points
