class_name SpikesTrap
extends Node2D

@export var damage: Damage
@export var difficulty_class: int = 10
@onready var hidden_spikes := $HiddenSpikes
@onready var released_spikes := $ReleasedTrapSpikes

var _state: State
var _detected := false

enum State {
	HIDDEN,
	RELEASED
}

func _ready() -> void:
	set_state(State.HIDDEN)

func _on_disarmed() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body is Unit and _state == State.HIDDEN:
		body.take_damage(damage)
		set_state(State.RELEASED)

func _on_detection_area_entered(body: Node2D) -> void:
	if _detected:
		return
	if body is not Unit:
		return
	var unit = body as Unit
	check_detection(unit)

func check_detection(unit: Unit):
	var check = Check.of_skill(difficulty_class, Skills.Skill.PERCEPTION)
	if await unit.check_on_fly(check):
		$DetectedOverlay.visible = true
		_detected = true
		%DisarmTrap.enabled = true

func _on_reset_timer_timeout() -> void:
	set_state(State.HIDDEN)

func set_state(state: State):
	match state:
		State.HIDDEN:
			hidden_spikes.visible = true
			released_spikes.visible = false
		State.RELEASED:
			hidden_spikes.visible = false
			released_spikes.visible = true
			$ResetTimer.start()
	_state = state

func is_interactable(_unit: Unit) -> bool:
	return _detected
