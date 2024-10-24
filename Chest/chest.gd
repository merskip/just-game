class_name Chest
extends Interaction

@export var items: Array[InventoryItem]
@export var closed_texture: Texture2D
@export var open_texture: Texture2D

@onready var _sprite := $Sprite2D
@onready var open_sfx := $OpenChest

var _state: State

enum State {
	CLOSED,
	OPEN
}

func _ready() -> void:
	set_state(State.CLOSED)

func is_interactable(unit: Unit) -> bool:
	return not items.is_empty()

func interact(unit: Unit):
	print("The chest was opened")
	unit.inventory.add_items(items)
	items.clear()
	set_state(State.OPEN)

func set_state(state: State):
	match state:
		State.CLOSED:
			_sprite.texture = closed_texture
		State.OPEN:
			_sprite.texture = open_texture
			if _state == State.CLOSED:
				open_sfx.play()
	self._state = state
