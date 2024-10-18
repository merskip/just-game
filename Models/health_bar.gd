extends ProgressBar

@onready var unit: Unit = $"../Unit"

func _on_health_change() -> void:
	_update_progress()

func _update_progress():
	value = unit._health
	max_value = unit._max_health
