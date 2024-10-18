class_name Player
extends CharacterBody2D

@export var speed: float = 300.0
@export var start_items: Array[InventoryItem]
@onready var unit: Unit = $Unit

func _ready() -> void:
	unit.inventory.add_items(start_items)

func _physics_process(_delta: float) -> void:
	var move = Vector3(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down"),
		0
	).normalized()
	velocity.x = move.x * speed
	velocity.y = move.y * speed

	move_and_slide()
