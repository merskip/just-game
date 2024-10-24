extends Node2D

@export var damage: Damage
@onready var hidden_spikes := $HiddenSpikes
@onready var released_spikes := $ReleasedTrapSpikes

var _state: State

enum State {
	HIDDEN,
	RELEASED
}

func _ready() -> void:
	set_state(State.HIDDEN)

func _on_body_entered(body: Node2D) -> void:
	if body is Unit and _state == State.HIDDEN:
		body.take_damage(damage)
		set_state(State.RELEASED)

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
